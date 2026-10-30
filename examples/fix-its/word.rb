require "fix/its"

Fix :Word do
  its(:size) { MUST eq 5 }
  its(:upcase) { MUST eq "HELLO" }
  its(:start_with?, "he") { MUST be_true }

  on :chars do
    its(:first) { MUST eq "h" }
  end
end

exit(Fix[:Word].test { "hello" })
