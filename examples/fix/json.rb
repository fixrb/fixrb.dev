require "fix"
require "json"

# What the application expects of a library it depends on, tested at each
# upgrade of that library.
Fix :JSON do
  on :generate, [1, 2] do
    it MUST eq "[1,2]"
  end

  on :parse, "[1,2]" do
    it MUST eq [1, 2]
  end

  on :parse, "nope" do
    it MUST raise_exception JSON::ParserError
  end

  on :pretty_generate, [1] do
    it SHOULD eq "[\n  1\n]"
  end
end

exit(Fix[:JSON].test { JSON })
