require_relative("treenode")

class KnightPathFinder
  attr_reader :root_node, :move_tree

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @move_tree = self.build_move_tree
    @considered_positions = [pos]
  end

  def build_move_tree
    self.root_node
  end

  def self.valid_moves(pos)
    valid_moves = []
    possible_moves = [
      [1,2],[1,-2],[2,1],[-2,1],
      [-1,2],[-1,-2],[2,-1],[-2,-1]
    ]

    possible_moves.each do |move| 
      row = pos[0] + move[0]
      col = pos[1] + move[1]
      if row > 0 && col > 0
        valid_moves << [row,col]
      end
    end
    valid_moves
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_moves = valid_moves.select {|move| !@considered_positions.include?(move)}
    new_moves.each {|move| @considered_positions << move}
  end



end

kp = KnightPathFinder.new([4,4])
p kp.new_move_positions([4,4])




"""
    knight start (type of move, position)
      /     \
    move 1  move1
  /
move 2
"""
