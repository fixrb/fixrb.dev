require "fix"

Fix :Score do
  it MUST satisfy { |score| score.between?(0, 100) }
  it MUST satisfy { |score| score.even? }
  it MUST satisfy { |score| score.to_s }
end

exit(Fix[:Score].test { 75 })
