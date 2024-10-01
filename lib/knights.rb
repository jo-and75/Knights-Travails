# frozen_string_literal: true

require 'set'

class Knights
  def initialize(start, finish)
    @finish_pos = finish
    @start_pos = knight_moves(start, @finish_pos)
  end

  MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze

  def knight_moves(start, finish, queue = [], visited_pos = Set.new([]))
    queue.push(start) unless queue.length > 1 # ensures start is only pushed on the first recursive call.
    p queue
    root_node = Node.new(queue[0])
    return  root_node if queue[0].empty?
    # return  if (finish[0]).negative? || finish[0] < 7 || (finish[1]).negative? || finish[1] > 7
    return  if root_node.nil?

    MOVES.each do |arr|
      result = arr.zip(queue[0]).map { |a, b| a + b }
      if (result[0] >= 0 && result[0] <= 7) && (result[1] >= 0 && result[1] <= 7) && visited_pos.include?(result) == false
        root_node.next_node.push(result)
      end
    end
    if visited_pos.include?(queue[0]) == false
      visited_pos << queue.shift
    else
      queue.shift
    end
    # p visited_pos
    root_node.next_node.each { |node| queue << node }
    knight_moves(root_node.next_node, finish, queue, visited_pos)
  end

  class Node
    attr_accessor :value, :next_node

    def initialize(value = [x, y], next_node = [])
      @value = value
      @next_node = next_node
    end
  end
end
