require_relative "product"

class Cart
  def initialize(*products)
    @products = products.freeze
  end

  def count = @products.size
  def total = @products.sum(&:price)
  def add(product) = Cart.new(*@products, product)
end
