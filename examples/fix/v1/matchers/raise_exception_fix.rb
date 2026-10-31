require "fix"

Fix :Stock do
  on :fetch, :pears do
    it MUST raise_exception KeyError
    it MUST raise_exception KeyError, "key not found: :pears"
    it MUST raise_exception IndexError
    it MUST raise_exception ArgumentError
    it MUST eq 0
  end

  on :fetch, :apples do
    it MUST raise_exception KeyError
  end
end

exit(Fix[:Stock].test { { apples: 3 } })
