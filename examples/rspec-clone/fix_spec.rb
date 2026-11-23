require "r_spec"
require "matchi/fix"

# What a duck does, as a specification of Fix.
Fix :Duck do
  on :walk do
    it MUST eq "Klop klop!"
  end

  on :speak do
    it MAY eq "Quaaaaaack!"
  end
end

Duck = Struct.new(:walk)

RSpec.describe "A specification of Fix, as a matcher" do
  let(:fix) { |name| Matchi::Fix.new(name) }

  it { expect(Duck.new("Klop klop!")).to fix(:Duck) }
  it { expect(Duck.new("Clank!")).not_to fix(:Duck) }
end
