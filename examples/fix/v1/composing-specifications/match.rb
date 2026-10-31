require "fix"

Fix :Empty do
  on :empty? do
    it MUST be_true
  end

  on :size do
    it MUST eq 0
  end
end

Fix[:Empty].match? { [] }    # => true
Fix[:Empty].match? { {} }    # => true
Fix[:Empty].match? { "" }    # => true
Fix[:Empty].match? { [nil] } # => false
