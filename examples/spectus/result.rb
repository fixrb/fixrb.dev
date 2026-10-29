require "spectus"
require "matchi"

# A result is plain data, frozen: it can be marshalled and shared.
result = Spectus.must(Matchi::Eq.new(42)).call { raise "boom" }
result.frozen?                              # => true
result.error_class                          # => "RuntimeError"
result.error_message                        # => "boom"
result.actual                               # => "#<RuntimeError: boom>"
result.summary                              # => "RuntimeError: boom"
Marshal.load(Marshal.dump(result)) == result # => true
Ractor.shareable?(result)                   # => true

# The texts are read defensively: nothing in a result runs user code again.
loud = Object.new
def loud.inspect = raise("no")
Spectus.must(Matchi::Eq.new(1)).call { loud }.actual # => "an object of Object"
