require "rspec/autorun"
require "rspec/fix"
require_relative "../fix/specs/duck"
require_relative "../lib/duck"

RSpec.configure { |config| config.include RSpec::Fix }

RSpec.describe Duck do
  it { is_expected.to fix(:Duck) }
end
