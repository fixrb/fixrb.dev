require "fix"

Fix :Email do
  it MUST match(/@example\.com\z/)
  it MUST_NOT match(/\s/)
  it MUST match(/\.org\z/)

  on :to_sym do
    it MUST match(/\Aada@/)
  end
end

exit(Fix[:Email].test { "ada@example.com" })
