require "fix"

Fix :Phrase do
  it MUST be_an_instance_of String

  on :upcase do
    it MUST eq "HELLO WORLD"

    on :length do
      it MUST eq 11
    end
  end

  on :split, " " do
    it MUST eq %w[hello world]
  end

  on :start_with?, "hello" do
    it MUST be_true
  end
end

exit(Fix[:Phrase].test { "hello world" })
