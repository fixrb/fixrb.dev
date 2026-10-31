require "fix"

Fix :Slug do
  on :downcase do
    on :tr, " ", "-" do
      it MUST eq "hello-world"
    end
  end
end

exit(Fix[:Slug].test { "Hello World" })
