require "fix"

# A stack, whatever it is made of.
Fix :Stack do
  on :push, 1 do
    on :pop do
      it MUST eq 1
    end
  end

  on :pop do
    it SHOULD be_nil
  end

  on :peek do
    it MAY be_nil
  end
end

# A test picks the subject: an Array.
exit(Fix[:Stack].test { [] })
