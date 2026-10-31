class LinkedStack
  Node = Data.define(:value, :below)

  def initialize = @top = nil
  def empty? = @top.nil?
  def push(value) = tap { @top = Node.new(value, @top) }

  def pop
    value = @top&.value
    @top = @top&.below
    value
  end
end
