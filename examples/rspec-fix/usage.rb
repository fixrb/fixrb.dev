require "rspec/fix"

Fix :Duck do
  on :walk do
    it MUST eq "Klop klop!"
  end

  on :swim do
    it SHOULD eq "Swoosh..."
  end

  on :speak do
    it MAY eq "Quaaack!"
  end
end

class Duck
  def walk = "Klop klop!"
  def swim = "Swoosh..."
  def speak = "Quaaack!"
end

class Robot
  def walk = "Klop klop!"
  def swim = "Glug glug..."
end

class RubberDuck
  def swim = "Swoosh..."
  def speak = "Squeak!"
end

# An example of RSpec has these words; here, outside a suite, the file takes them.
include RSpec::Matchers
include RSpec::Fix

expect(Duck.new).to fix(:Duck)  # => true
expect(Robot.new).to fix(:Duck) # => true

begin
  expect(RubberDuck.new).to fix(:Duck)
rescue RSpec::Expectations::ExpectationNotMetError => e
  puts e.message
end
