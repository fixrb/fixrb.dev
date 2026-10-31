require "fix"

Fix :Empty do
  on :empty? do
    it MUST be_true
  end

  on :size do
    it MUST eq 0
  end
end

Fix :Stack do
  it MUST fix(:Empty)

  on :push, 1 do
    it MUST_NOT fix(:Empty)

    on :last do
      it MUST eq 1
    end
  end
end

exit(Fix[:Stack].test { [] })
