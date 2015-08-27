require 'pry'

class BinarySearchTree
  attr_reader :root_node

  def push(data, current_node=root_node)
    if root_node.nil?
      @root_node = Node.new(data, nil, nil, true)
    elsif data <= current_node.data
      if current_node.left
        push(data, current_node.left)
      else
        current_node.left = Node.new(data)
      end
    elsif data > current_node.data
      if current_node.right
        push(data, current_node.right)
      else
        current_node.right = Node.new(data)
      end
    end
  end

end

class Node
  attr_accessor :data,
                :left,
                :right,
                :root

  def initialize(data, left=nil, right=nil, root=false)
    @data  = data
    @left  = left
    @right = right
    @root = root
  end


end
