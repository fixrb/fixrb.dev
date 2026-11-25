require "fix"

Fix :Duck do
  on :walk do
    it MUST eq "Klop klop!"
  end

  on :swim do
    it SHOULD eq "Swoosh..."
  end

  on :speak do
    it MAY eq "Quaaack!"
  end
end
