set a 1
switch $a {
    1 {puts 1}
    2 {puts 2}
    3 -
    default {puts heh}
}

set b 4
while { $b >= 0 } {
    puts $b 
    # set b [expr $b-1]
    incr b -1
}

foreach {x y} {a b c d} {
    puts $x.$y
}

set cmds {
    puts a
    puts b
}
eval $cmds


