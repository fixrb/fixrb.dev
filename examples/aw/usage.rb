require "aw"

list = ["foo"]

Aw.fork! { list << "bar" } # => ["foo", "bar"]
list                       # => ["foo"]

Aw.fork? { list.fetch(0) } # => true
Aw.fork? { list.fetch(1) } # => false
