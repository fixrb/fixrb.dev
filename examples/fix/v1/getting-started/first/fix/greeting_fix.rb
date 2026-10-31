require "fix"
require_relative "../lib/greeting"

Fix :Greeting do
  on :call, "Alice" do
    it MUST eq "Hello, Alice!"
  end
end

exit(Fix[:Greeting].test { Greeting.new })
