require "spectus"
require "matchi"

# A method the value does not have: an error for MUST and SHOULD, an info
# for MAY, where the method is optional.
blank = Matchi::Predicate.new(:be_blank)
Spectus.must(blank).call { "" }.outcome   # => :error
Spectus.should(blank).call { "" }.outcome # => :error
Spectus.may(blank).call { "" }.outcome    # => :info
Spectus.may(blank).call { "" }.passed?    # => true

# A match that is false: a failure, or a warning for SHOULD.
empty = Matchi::Predicate.new(:be_empty)
Spectus.must(empty).call { [1] }.outcome   # => :failure
Spectus.should(empty).call { [1] }.outcome # => :warning
Spectus.may(empty).call { [1] }.outcome    # => :failure

# An exception the block raises reaches the matcher, which may expect it.
raises = Matchi::RaiseException.new(ZeroDivisionError)
Spectus.must(raises).call { 1 / 0 }.outcome          # => :success
Spectus.must(Matchi::Eq.new(1)).call { 1 / 0 }.outcome     # => :error
Spectus.must(Matchi::Eq.new(1)).call { 1 / 0 }.error_class # => "ZeroDivisionError"
