require "fix"

Fix :Account do
  on :balance do
    it MUST eq 100
    it SHOULD eq 200
  end
end

Account = Struct.new(:balance)

exit(Fix[:Account].test { Account.new(100) })
