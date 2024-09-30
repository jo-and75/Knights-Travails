class Knights
  def initialize(start,finish,queue) 
    @finish_pos = nil
    @start_pos = knight_moves(start,@finish_pos,queue)
  end

  MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

  def knight_moves(start, finish, queue = []) 
    return nil if finish[0] < 0 || finish[0] > 7 || finish[1] < 0 || finish[1] > 7
    queue.push(start)
    return if @start_pos.next_node.include?(finish) 
    return if nil 
    @start_pos = Node.new(queue[0])
      MOVES.each do |arr|
        result = arr.zip(queue[0]).map { |a, b| a + b }
        @start_pos.next_node.push(result) if (0 <= result[0] && result[0] <= 7) && (0 <= result[1] && result[1] <= 7)
      end  
      @start_pos.next_node = queue
      queue.shift
  
      p @start_pos.value 
      p @start_pos.next_node
  end

  class Node
    attr_accessor :value, :next_node

    def initialize(value = [x, y], next_node = [nil, nil])
      @value = value
      @next_node = next_node
    end
  end
end
