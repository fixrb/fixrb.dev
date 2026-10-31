require "fix"

Player = Data.define(:name, :score)

Fix :Player do
  on :name do
    it MUST eq "Ada"
  end

  on :score do
    it MUST_NOT be_nil
    it SHOULD eq 100
  end

  on :avatar do
    it MAY match(/\.png\z/)
  end
end

exit(Fix[:Player].test { Player.new(name: "Ada", score: 90) })
