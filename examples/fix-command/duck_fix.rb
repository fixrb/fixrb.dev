require "fix"

Fix :Duck do
  on :quack do
    it MUST eq "Quack!"
  end

  on :swim do
    it MAY eq "Splash!"
  end
end

class Duck
  def quack = "Quack!"
end

exit(Fix[:Duck].test { Duck.new })
