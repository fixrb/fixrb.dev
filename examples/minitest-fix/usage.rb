require "minitest"
require "minitest/fix"

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

class DuckTest < Minitest::Test
  include Minitest::Fix

  def test_duck = assert_fix(:Duck, Duck.new)
  def test_robot = assert_fix(:Duck, Robot.new)
  def test_rubber_duck = assert_fix(:Duck, RubberDuck.new)
end

# minitest/autorun would run the tests and write its report, with a seed and
# times; here each test is run by hand, so that the file writes the same lines
# every time.
DuckTest.new("test_duck").run.passed?  # => true
DuckTest.new("test_robot").run.passed? # => true

puts DuckTest.new("test_rubber_duck").run.failure.message
