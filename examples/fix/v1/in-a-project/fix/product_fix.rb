require "fix"
require_relative "../lib/product"

Fix :Product do
  on :name do
    it MUST be_an_instance_of String
  end

  on :price do
    it MUST be_a_kind_of Numeric
  end
end

exit(Fix[:Product].test { Product.new(name: "Tea", price: 4) })
