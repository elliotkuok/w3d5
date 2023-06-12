require_relative("treenode")
require("byebug")

class KnightPathFinder
  attr_reader :root_node, :move_tree, :considered_positions

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
    @move_tree = self.build_move_tree
  end

  def build_move_tree
    q = Queue.new
    q.enq(@root_node)

    until q.empty?
      current = q.deq
      # Create new nodes with possible move positions.
      new_pos = new_move_positions(current.value)
      new_pos.each do |pos|
        new_node = PolyTreeNode.new(pos)
        current.add_child(new_node)
        new_node.parent = current
        q << new_node
      end
    end
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
      # Make sure move is on 8x8 board.
      if (row > 0 && col > 0) && (row <=7 && col <= 7)
        valid_moves << [row,col]
      end
    end
    valid_moves
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    # Filter out moves that have not yet been considered.
    new_moves = valid_moves.select {|move| !@considered_positions.include?(move)}
    new_moves.each {|move| @considered_positions << move}
  end

  def find_path(end_pos)
    target_node = @root_node.bfs(end_pos)
    trace_path_back(target_node)
  end
  
  def trace_path_back(current_node)
    path_back = [current_node.value]
    current_parent = current_node.parent
    until current_parent == @root_node
      path_back.unshift(current_parent.value) # adds position to front of path_back
      #move up a node
      current_node = current_parent
      current_parent = current_parent.parent
    end
    path_back.unshift(current_parent.value)
    path_back
  end

end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]



"""
            knight start [0,0]
              /     \
            b       c
          /   \     / \
        m1    m2   m1  m2
"""
