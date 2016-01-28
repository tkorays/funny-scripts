
puts [dict create a 1 b 2]
puts [dict append {} a 2]
puts [dict exists {a 2} a]

dict for {k v} {a 1 b 2} {
    puts $k->$v
}
puts [dict get {a 1 b 2} a]
puts [dict keys {a 1 b 2}]
# dict merge lappend replace set size
puts [dict size {a 1 b 2}]
# dict unset.set.update
