require "fix"

Fix :Greeting do
  let(:name) { "Bob" }

  it MUST eq "Hello, Bob!"
  it MUST_NOT be_nil

  on :size do
    it MUST eq 11
  end

  with name: "Alice" do
    it MUST eq "Hello, Alice!"
  end
end

exit(Fix[:Greeting].test { "Hello, #{name}!" })
