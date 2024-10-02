# frozen_string_literal: true

require 'set'

class Knights
  attr_accessor :start_pos

  def initialize(start, finish)
    @finish_pos = finish
    @start_pos = draw_board(start)
    # knight_moves
  end

  MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze

  def draw_board(start, queue = [], visited_pos = Set.new([]))
    if queue.length < 1
      root_node = Node.new(start)
      queue.push(root_node)
    else
      root_node = queue[0]
    end

    # p root_node.value
    # p visited_pos.length
    # p queue[0].value.empty?
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
    # p queue
    # p visited_pos
    draw_board(root_node.next_node, queue, visited_pos)
  end

  def knight_moves(node = @start_pos, line = [])
    line.push(node)
    puts line[0]
    loop do
      break if line[0] == @finish_pos

      temp_node = line[0]
      line.push(temp_node.next_node) unless temp_node.nil?
      puts temp_node.value
      line.shift
      p line
    end
  end

  class Node
    attr_accessor :value, :next_node

    def initialize(value = [x, y], next_node = [])
      @value = value
      @next_node = next_node
    end
  end
end
