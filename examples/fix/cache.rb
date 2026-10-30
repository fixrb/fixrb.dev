require "fix"

# What the application needs from a cache: a contract, in three levels.
Fix :Cache do
  let(:entries) { {} }

  on :read, :answer do
    it MUST be_nil
  end

  with entries: { answer: 42 } do
    on :read, :answer do
      it MUST eq 42
    end
  end

  on :write, :answer, 42 do
    it SHOULD be_true
  end

  on :clear do
    it MAY be_nil
  end
end

class MemoryCache
  def initialize = @store = {}
  def read(key) = @store[key]
  def write(key, value) = @store[key] = value
end

exit(Fix[:Cache].test { entries.each_with_object(MemoryCache.new) { |(key, value), cache| cache.write(key, value) } })
