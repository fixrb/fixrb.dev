require "fix"

class Duck
  def walk = "Klop klop!"
  def swim = "Swoosh..."
end

Fix :Duck do
  on :walk do
    it MUST eq "Klop klop!"
  end

  on :swim do
    it MUST eq "Swoosh..."
  end

  on :speak do
    it MAY eq "Quaaaaaack!"
  end
end

exit(Fix[:Duck].test { Duck.new })
