require "fix"

Fix :Team do
  on :size do
    it MUST eq 3
  end

  on :first do
    it MUST eq "Ada"
  end
end

exit(Fix[:Team].test { %w[Ada Grace Linus] })
