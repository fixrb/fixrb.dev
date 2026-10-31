require "fix/its"

Fix :Team do
  its(:size) { MUST eq 3 }
  its(:first) { MUST eq "Ada" }
  its(:include?, "Linus") { MUST be_true }
  its(:join, ", ") { MUST eq "Ada, Grace, Linus" }

  on :last do
    its(:length) { MUST eq 5 }
  end
end

exit(Fix[:Team].test { %w[Ada Grace Linus] })
