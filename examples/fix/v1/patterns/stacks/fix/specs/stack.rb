require "fix"

Fix :Stack do
  on :empty? do
    it MUST be_true
  end

  on :push, 1 do
    on :push, 2 do
      on :pop do
        it MUST eq 2
      end
    end
  end

  on :pop do
    it MUST be_nil
  end
end
