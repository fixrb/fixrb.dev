require "minitest/autorun"
require "minitest/fix"
require_relative "../fix/specs/duck"
require_relative "../lib/duck"

class DuckTest < Minitest::Test
  include Minitest::Fix

  def test_duck_meets_its_specification
    assert_fix :Duck, Duck.new
  end
end
