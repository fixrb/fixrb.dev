require "fix"

# A specification
Fix :Calculator do
  on(:new, 2) do
    on(:add, 3) do
      it MUST be 5
    end
  end
end

# An implementation
class Calculator
  def initialize(first)
    @first = first
  end

  def add(second)
    @first + second
  end
end

# A test
Fix[:Calculator].test { Calculator }
