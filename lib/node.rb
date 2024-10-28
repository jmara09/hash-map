class Node
  attr_accessor :value, :next_node

  def initialize(val = nil, next_node = nil)
    @value = val
    @next_node = next_node
  end
end
