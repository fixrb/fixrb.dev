require "defi"
require "matchi"
require "spectus"

# expect { "foo".upcase }.to eq "FOO": a matcher of Matchi, in a MUST of
# Spectus, called with the block.
upcase = Spectus.must(Matchi::Eq.new("FOO")).call { "foo".upcase }
upcase.to_s # => "Success: expected \"FOO\" to eq \"FOO\""

# expect("foo").not_to be_nil: a MUST NOT.
present = Spectus.must_not(Matchi::Be.new(nil)).call { "foo" }
present.to_s # => "Success: expected \"foo\" not to be nil"

# its(:size) { is_expected.to eq 3 }, on "foo": Defi sends the method inside
# the block, so that what it raises can be judged too.
size = Defi::Challenge.new(:size)
sized = Spectus.must(Matchi::Eq.new(3)).call { size.to("foo").call }
sized.to_s # => "Success: expected 3 to eq 3"
