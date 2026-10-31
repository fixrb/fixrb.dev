require "fix"
require "json"

Fix :JSON do
  on :generate, { "id" => 1 } do
    it MUST eq '{"id":1}'
  end

  on :parse, '{"id":1}' do
    it MUST eq({ "id" => 1 })
  end

  on :parse, '{"id":1}', symbolize_names: true do
    it MUST eq({ id: 1 })
  end
end

exit(Fix[:JSON].test { JSON })
