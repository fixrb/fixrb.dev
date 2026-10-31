require "fix"

Fix :Plugin do
  on :call, "text" do
    it MUST be_an_instance_of String
  end

  on :name do
    it SHOULD match(/\A[a-z]+\z/)
  end

  on :version do
    it MAY match(/\A\d+\.\d+\z/)
  end
end

class Upcase
  def call(text) = text.upcase
  def name = "Upcase"
end

class Reverse
  def call(text) = text.reverse
  def name = "reverse"
  def version = "1.2"
end

results = [
  Fix[:Plugin].test { Upcase.new },
  Fix[:Plugin].test { Reverse.new }
]

exit(results.all?)
