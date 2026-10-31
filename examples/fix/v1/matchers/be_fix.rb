require "fix"

DEFAULTS = { color: :blue }.freeze

Settings = Data.define(:defaults)

Fix :Settings do
  on :defaults do
    it MUST be DEFAULTS
    it MUST eq({ color: :blue })
    it MUST be({ color: :blue })
  end
end

exit(Fix[:Settings].test { Settings.new(DEFAULTS) })
