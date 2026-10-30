require "fix"

Fix :Stack do
  on :empty? do
    it MUST be_true
  end

  on :push, 1 do
    on :push, 2 do
      on :pop do
        it MUST eq 2
      end

      on :size do
        it MUST eq 2
      end
    end
  end

  on :pop do
    it MUST be_nil
  end
end

class LinkedStack
  Node = Data.define(:value, :below)

  def initialize = @top = nil
  def empty? = @top.nil?
  def size = each_node.count
  def push(value) = tap { @top = Node.new(value, @top) }

  def pop
    value = @top&.value
    @top = @top&.below
    value
  end

  private

  def each_node
    return to_enum(:each_node) unless block_given?

    node = @top
    while node
      yield node
      node = node.below
    end
  end
end

Fix[:Stack].test { [] }               # => true
Fix[:Stack].test { LinkedStack.new } # => true
