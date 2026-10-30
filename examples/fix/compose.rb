require "fix"

Fix :Positive do
  on :positive? do
    it MUST be_true
  end
end

Fix :Score do
  it MUST be_a_kind_of Numeric
  it MUST fix(:Positive)
  it MUST_NOT fix { on(:nan?) { it MUST be_true } }
end

exit(Fix[:Score].test { 7.5 })
