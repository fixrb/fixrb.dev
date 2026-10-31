require "fix"

class BeEven
  def match? = yield.even?
  def to_s = "be even"
end

Fix :Pair do
  on :size do
    it MUST BeEven.new
  end

  on :first do
    it MUST BeEven.new
  end
end

exit(Fix[:Pair].test { [1, 2] })
