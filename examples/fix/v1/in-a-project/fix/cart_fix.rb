require "fix"
require_relative "../lib/cart"

TEA = Product.new(name: "Tea", price: 4)
CAKE = Product.new(name: "Cake", price: 6)

Fix :Cart do
  let(:products) { [] }

  on :count do
    it MUST eq 0
  end

  with products: [TEA, CAKE] do
    on :total do
      it MUST eq 10
    end

    on :add, TEA do
      on :count do
        it MUST eq 3
      end
    end
  end
end

exit(Fix[:Cart].test { Cart.new(*products) })
