require "defi"

# What a method raises on its own comes back as the value.
Defi::Challenge.new(:+, 1).to("a").object.class     # => TypeError
Defi::Challenge.new(:secret).to(Object.new).object.class # => NoMethodError

exiting = Object.new
def exiting.call = exit(3)
Defi::Challenge.new(:call).to(exiting).object.status # => 3

# What is not the method's doing goes through.
interrupting = Object.new
def interrupting.call = raise(Interrupt)
outcome = begin
  Defi::Challenge.new(:call).to(interrupting)
rescue Interrupt
  :went_through
end
outcome # => :went_through
