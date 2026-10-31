require "fix"

Fix :Duck do
  on :quack do
    it MUST eq "Quack!"
  end

  on :swim do
    it SHOULD eq "Splash!"
  end

  on :fly do
    it MAY be_true
  end
end

class Duck
  def quack = "Quack!"
  def swim = "Splash!"
  def fly = true
end

class RubberDuck
  def quack = "Quack!"
  def swim = "Splash!"
end

exit([
  Fix[:Duck].test { Duck.new },
  Fix[:Duck].test { RubberDuck.new }
].all?)
