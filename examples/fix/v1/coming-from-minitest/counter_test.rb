require "minitest/autorun"

class Counter
  attr_reader :count

  def initialize(start) = @count = start
  def increment = tap { @count += 1 }
end

class CounterTest < Minitest::Test
  def setup
    @counter = Counter.new(0)
  end

  def test_count
    assert_equal 0, @counter.count
  end

  def test_count_after_an_increment
    assert_equal 1, @counter.increment.count
  end

  def test_count_from_five
    assert_equal 5, Counter.new(5).count
  end
end
