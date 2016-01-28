
set s_a "hello world"

# string index
puts {>> string index "hello world" end-1 }
puts [string index $s_a end-1]

# string range
puts {>> string range $s_a 0 end}
puts [string range $s_a 0 end]

puts {>> string length $s_a}
puts [string length $s_a]

puts {>> string toupper $s_a}
puts [string toupper $s_a]

puts {>> string trim $s_a ld}
puts [string trim $s_a ld]

puts {>> string repeat "*" 5}
puts [string repeat "*" 5]

# simple search
puts [string first ld $s_a]

puts [string compare dog Dog]
puts [string equal dog Dog]
puts [string equal -length 3 -nocase dog Dog]

# string replace
puts [string replace "hello world" 6 end "heh"]

set user {
    username tkorays 
    password hehehe
}

# map 替换
puts [string map -nocase $user "Dear userName,you pass is Password"]

puts [string is digit 1233]
puts [string is digit "abcd"]

puts [format "heheh %s" "tkorays"]

set n ""
puts [scan "hehh tkorays" "hehh %s" n]
puts $n


puts [string match {*.[ch]} "ab.c"]

puts [regexp {^cat\w+g$} "catlog"]


# string [match index length map range replace toupper trim lefttrim righttrim]
# format scan
#



