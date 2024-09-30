class Knights
  def initialize(start,finish) 
    @finish_pos = finish
    @start_pos = knight_moves(start,@finish_pos)
  end

  MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

  def knight_moves(start, finish, queue = [])    
    queue.push(start) unless queue.length > 1 #ensures start is only pushed on the first recursive call.
    root_node = Node.new(queue[0])  
    return nil if finish[0] < 0 || finish[0] > 7 || finish[1] < 0 || finish[1] > 7 
    return nil if root_node.nil? 
    return root_node if root_node.value == finish
  
    MOVES.each do |arr|
      result = arr.zip(queue[0]).map { |a, b| a + b }
      root_node.next_node.push(result) if (0 <= result[0] && result[0] <= 7) && (0 <= result[1] && result[1] <= 7)
    end    
    queue.shift   
    root_node.next_node.each {|node| queue << node}  
    p root_node
    knight_moves(root_node.next_node,finish,queue)  
   
  end

  class Node
    attr_accessor :value, :next_node

    def initialize(value = [x, y], next_node = [])
      @value = value
      @next_node = next_node
    end
  end
end
