require "fix"

Circle = Data.define(:radius) do
  def area = Math::PI * radius**2
end

Fix :Circle do
  on :area do
    it MUST be_within(0.01).of(3.14)
    it MUST be_within(0.001).of(3.14)
  end
end

exit(Fix[:Circle].test { Circle.new(radius: 1) })
