require "fix"

Fix :Tax do
  on :*, 0.2 do
    it MUST eq 20
  end
end

exit(Fix[:Tax].test { 100 })
