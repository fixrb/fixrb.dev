require "fix"

Fix :Half do
  on :to_s do
    it MUST eq "1/2"
  end

  on :to_f do
    it MUST eq 0.5
  end

  on :numerator do
    it MUST eq 1.0
  end
end

exit(Fix[:Half].test { Rational(1, 2) })
