class Knights 
  def initialize 
    @start_pos = nil 
    @finish_pos = nil
  end 

  def knight_moves(start,finish) 
    @start_pos = Node.new(start)
    puts @start_pos.value

  end








  class Node 
    attr_accessor :value , :next_node
    def initialize(value, next_node = [])
      @value = value
      @next_node = next_node
    end
  end
end
