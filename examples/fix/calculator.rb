require "fix"

# A specification: what a calculator does, whatever it is made of.
Fix :Calculator do
  on :add, 2, 3 do
    it MUST eq 5
  end

  on :divide, 1, 0 do
    it MUST raise_exception ZeroDivisionError
  end
end

# An implementation.
module Calculator
  def self.add(a, b) = a + b
  def self.divide(a, b) = a / b
end

# A test: the specification names no class, the test picks the subject.
exit(Fix[:Calculator].test { Calculator })
