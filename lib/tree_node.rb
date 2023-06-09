class PolyTreeNode
    attr_reader :children, :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    @parent.children.delete(self) if @parent
    @parent = new_parent

    if new_parent
        @parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    @children.include?(child_node) ? child_node.parent = nil : raise
  end
end


"""
    a
   / \
  b   c
 /
d
"""
