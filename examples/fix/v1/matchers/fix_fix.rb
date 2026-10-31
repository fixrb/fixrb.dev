require "fix"

Fix :Filled do
  on :empty? do
    it MUST be_false
  end
end

Fix :Name do
  it MUST be_an_instance_of String
  it MUST fix(:Filled)
  it MUST fix { on(:strip) { it MUST eq "Ada" } }
end

exit(Fix[:Name].test { "Ada" })
