# frozen_string_literal: true

require 'set'

class Knights
  attr_accessor :start_pos, :finish_pos

  def initialize(start, finish)
    @finish_pos = finish
    @start_pos = draw_board(start)
    knight_moves
  end

  MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze

  def draw_board(start, queue = [], visited_pos = Set.new([]))
    if queue.length < 1
      root_node = Node.new(start)
      queue.push(root_node)
    else
      root_node = queue[0]
    end

    return root_node if queue[0].value.empty?
    return root_node if root_node.nil?

    MOVES.each do |arr|
      result = arr.zip(queue[0].value).map { |a, b| a + b }
      if (result[0] >= 0 && result[0] <= 7) && (result[1] >= 0 && result[1] <= 7) && visited_pos.include?(result) == false
        root_node.next_node.push(Node.new(result))
      end
    end
    root_node.next_node.each { |node| queue << node }

    if visited_pos.include?(queue[0].value)
      queue.shift
    else
      visited_pos << queue[0].value
      queue.shift
    end

    draw_board(root_node.next_node, queue, visited_pos)
    root_node
  end

  def knight_moves(node = @start_pos)
    queue = [[node]] # Queue of paths, starting with the initial node
    visited = Set.new([node.value]) # Keep track of visited positions

    until queue.empty?
      path = queue.shift # Get the next path to explore
      current_node = path.last # The current node is the last in the path

      if current_node.value == @finish_pos
        # We've found the shortest path, display it
        puts "You made it in #{path.length - 1} moves! Here's your path:"
        path.each { |n| p n.value }
        return # Exit the method after displaying the path
      end

      # Explore next nodes
      current_node.next_node.each do |next_node|
        next if visited.include?(next_node.value)

        visited.add(next_node.value)
        new_path = path + [next_node]
        queue.push(new_path)
      end
    end

    puts 'No path found!'
  end

  class Node
    attr_accessor :value, :next_node

    def initialize(value = [x, y], next_node = [])
      @value = value
      @next_node = next_node
    end
  end
end
