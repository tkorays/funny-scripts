
puts [lindex {abc bcd ecf} 2]

set l {a b c d e}
puts [llength $l]
# lappend varname varname
# Not!! lappend $list var
lappend l abc
puts $l

lassign $l a b c
puts $a 
puts $b

# Join split
puts [join $l "-"]

puts [concat $l {1 2 3}]

puts [linsert $l 2 ac efg]

puts [list a c 1 3 4]

puts [lrange {1 2 3 4 5} 2 3]


puts [split "abc-efg-123" "-"]

puts [lrepeat 4 abc]
