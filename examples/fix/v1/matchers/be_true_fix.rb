require "fix"

Fix :Word do
  on :empty? do
    it MUST be_false
  end

  on :index, "z" do
    it MUST be_nil
  end

  on :size do
    it MUST be_true
  end
end

exit(Fix[:Word].test { "word" })
