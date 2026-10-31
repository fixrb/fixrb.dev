require "fix"

Fix :Tax do
  on :*, 0.2 do
    it MUST eq 20
  end
end

results = Fix[:Tax].run { 100 }
results.map(&:outcome)  # => [:failure]
result = results.first
result.passed?          # => false
result.chain            # => ".*(0.2)"
result.summary          # => "expected 20.0 to eq 20"
