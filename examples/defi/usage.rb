require "defi"

challenge = Defi::Challenge.new(:fetch, :b, 0)
challenge.to_s # => ".fetch(:b, 0)"

value = challenge.to({ b: 2 })
value.raised? # => false
value.object  # => 2
value.call    # => 2

value = Defi::Challenge.new(:fetch, :b).to({})
value.raised?     # => true
value.object      # => #<KeyError: key not found: :b>
value.call rescue $!.class # => KeyError

Defi::Challenge.new(:encode, "US-ASCII", undef: :replace).to("café").object # => "caf?"
Defi::Challenge.new(:map) { |n| n * 2 }.to([1, 2]).object # => [2, 4]
