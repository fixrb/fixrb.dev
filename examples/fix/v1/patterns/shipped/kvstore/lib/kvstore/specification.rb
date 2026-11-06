require "fix"

# What the kvstore gem asks of a store, shipped with the gem for those
# who write one.
Fix :KVStore do
  on :fetch, :missing do
    it MUST be_nil
  end

  on :store, :answer, 42 do
    on :fetch, :answer do
      it MUST eq 42
    end
  end

  on :delete, :missing do
    it SHOULD be_nil
  end

  on :size do
    it MAY eq 0
  end
end
