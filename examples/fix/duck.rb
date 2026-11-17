require "fix"

# What a duck does, whatever it is made of.
Fix :Duck do
  on :walk do
    it MUST eq "Klop klop!"
  end

  on :swim do
    it SHOULD eq "Swoosh..."
  end

  on :speak do
    it MAY eq "Quaaaaaack!"
  end
end

class Duck
  def walk = "Klop klop!"
  def swim = "Swoosh..."
  def speak = "Quaaaaaack!"
end

class Robot
  def walk = "Klop klop!"
  def swim = "Glug glug..."
end

duck = Fix[:Duck].test { Duck.new }
robot = Fix[:Duck].test { Robot.new }
exit(duck && robot)
