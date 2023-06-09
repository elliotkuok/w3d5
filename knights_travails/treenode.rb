require "byebug"

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

    @parent.children << self if new_parent
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    @children.include?(child_node) ? child_node.parent = nil : raise
  end

  def dfs(target)
    return self if self.value == target
    return nil if self.children.empty?

    self.children.each do |child|
        node = child.dfs(target)
        return node unless node.nil?
    end
    nil
  end

  def bfs(target)
    q = Queue.new
    q.enq(self)

    until q.empty?
        curr = q.deq
        return curr if curr.value == target
        curr.children.each {|child| q.enq(child)}
    end
    nil
  end

end

"""
    a
   / \
  b   c
 /
d
"""

