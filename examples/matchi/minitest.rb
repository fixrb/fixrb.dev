require "matchi"
require "minitest/autorun"

class TestAnswer < Minitest::Test
  def assert_matches(matcher, actual)
    message = "expected #{actual.inspect} to #{matcher}"
    assert matcher.match? { actual }, message
  end

  def test_answer
    assert_matches Matchi::BeAKindOf.new(Integer), 42
    assert_matches Matchi::BeWithin.new(0.01).of(0.3), 0.1 + 0.2
  end
end
