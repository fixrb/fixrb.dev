require "fix"

# A subject with a global state: every context starts from the state the
# file was loaded with, since each one runs in a child process.
module Registry
  NAMES = []

  def self.add(name) = tap { NAMES << name }
  def self.names = NAMES
end

Fix :Registry do
  on :add, "Alice" do
    on :names do
      it MUST eq ["Alice"]
    end
  end

  on :add, "Bob" do
    on :names do
      it MUST eq ["Bob"]
    end
  end

  on :names do
    it MUST eq []
  end
end

exit(Fix[:Registry].test { Registry })
