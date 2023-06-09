require_relative("treenode")

class KnightPathFinder
  attr_reader :root_node, :move_tree

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @move_tree = self.build_move_tree
  end

  def build_move_tree
    self.root_node
  end


end

kp = KnightPathFinder.new([0,0])
p kp.root_node
p kp.move_tree



"""
    knight start (type of move, position)
      /     \
    move 1  move1
  /
move 2
"""
