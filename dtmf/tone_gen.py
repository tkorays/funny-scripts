"""
ToneGenerator
-------------

Usage
-----
if __name__ == '__main__':
    tg = ToneGenerator()
    tg.gen_from_cfg('cfg.txt')

or directly call function add_tone, add_silence, write_to_file.

config file format:
# size, freq1, freq2, ..., amp1, amp2, ..., ontime, offtime
%filename1.wav
2, 697, 1209, 0.4, 0.4, 40, 40
2, 697, 1336, 0.4, 0.4, 40, 40
%filename2.wav
2, 941, 1633, 0.4, 0.4, 40, 40
3, 697, 1209, 500, 0.4, 0.4, 0.2, 40, 40

# follows comment.
% follows filename.
The first column represent the size of frequents and amplitude.
The last two columns mean on-time and off-time in DTMF.

About
-----
Author: xujian<tkorays@hotmail.com>

"""
import numpy
import math
import wave


class ToneGenerator:
    def __init__(self):
        self.data = numpy.array([])
        self.SAMPLE_RATE = 8000

    def add_tone(self, fsize, freqs, amps, ontime_ms, offtime_ms):
        if fsize != len(freqs) and fsize != len(amps):
            return None
        self.data = numpy.concatenate([self.data, ToneGenerator.gen_normalized_tone(
            fsize, freqs, amps, float(ontime_ms)/1000, float(offtime_ms)/1000, self.SAMPLE_RATE
        )])

    def add_silence(self, silence_ms):
        self.data = numpy.concatenate([self.data, numpy.array([0]*int(silence_ms*self.SAMPLE_RATE/1000))])

    def write_to_file(self, filename):
        f = wave.open(filename, 'w')
        length = len(self.data)
        f.setparams((1, 2, self.SAMPLE_RATE, 0, 'NONE', 'not compressed'))
        for i in range(length):
            pt = int(self.data[i]*32767)
            MS8bit = pt >> 8
            LS8bit = pt-(MS8bit << 8)
            b = bytearray([0, 0])
            b[1] = MS8bit & 0xFF
            b[0] = LS8bit & 0xFF
            f.writeframes(b)
        f.close()

    def gen_from_cfg(self, cfg_file):
        out_file_name = ''
        f = open(cfg_file, 'r')
        if not f:
            print("cfg file({}) not exist!".format(cfg_file))
            return False
        for line in open(cfg_file):
            line = f.readline().replace('\n', '').replace('\r', '')
            if line[0] == '#':
                continue
            if line[0] == '%':
                if out_file_name:
                    self.add_silence(40)
                    self.write_to_file(out_file_name)
                out_file_name = line[1:].replace('\n','').replace('\r', '').replace(' ', '')
                self.data = numpy.array([])
                continue
            cfg = line.split(',')
            fsize = int(cfg[0])
            if len(cfg) != (3+2*fsize):
                print('bad cfg line')
                continue
            freqs = []
            amps = []
            for i in range(fsize):
                freqs.append(int(cfg[1+i]))
                amps.append(float(cfg[1+fsize+i]))
            ontime_ms = int(cfg[1+2*fsize])
            offtime_ms = int(cfg[1+2*fsize+1])
            self.add_tone(fsize, freqs, amps, ontime_ms, offtime_ms)
        f.close()
        if out_file_name:
            self.add_silence(40)
            self.write_to_file(out_file_name)


    @staticmethod
    def gen_sin_wave(freq, ontime, rate):
        ontime_length = int(ontime*rate)
        factor = float(freq)*(math.pi*2)/rate
        return numpy.sin(numpy.arange(ontime_length)*factor)

    @staticmethod
    def gen_normalized_tone(fsize, freqs, amps, ontime, offtime, rate):
        if len(freqs) != fsize and len(amps) != fsize:
            print('freq size or apm size error!')

        tone = numpy.sin(numpy.arange(int(ontime*rate)))*0
        for i in range(fsize):
            tone += ToneGenerator.gen_sin_wave(freqs[i], ontime, rate)*amps[i]

        silence = numpy.array([0]*int(offtime*rate))
        return numpy.concatenate([silence, numpy.divide(tone, 2.0)])


if __name__ == '__main__':
    tg = ToneGenerator()
    tg.gen_from_cfg('cfg.txt')
