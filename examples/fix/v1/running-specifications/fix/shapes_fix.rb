require "fix"

Square = Data.define(:side) do
  def area = side * side
end

Circle = Data.define(:radius) do
  def area = Math::PI * radius**2
end

Fix :Square do
  on :area do
    it MUST eq 4
  end
end

Fix :Circle do
  on :area do
    it MUST be_within(0.01).of(3.14)
  end
end

results = [
  Fix[:Square].test { Square.new(side: 2) },
  Fix[:Circle].test { Circle.new(radius: 1) }
]

exit(results.all?)
