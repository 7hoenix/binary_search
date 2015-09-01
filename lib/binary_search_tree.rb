require 'pry'

class BinarySearchTree
  attr_reader :root_node,
              :count

  def initialize
    @count = 0
  end

  def push(data, current_node=root_node)
    if empty?
      insert_on_root(data)
    else
      insert_in_tree(data, current_node)
    end
  end

  def include?(data, current_node=root_node)
    if empty?
      false
    else
      included_in_tree?(data, current_node)
    end
  end

  def to_array(elements=[], current_node=root_node)
    if empty?
      elements
    else
      load_tree((elements << current_node.data), current_node)
    end
    elements
  end

  def load_tree(elements, current_node)
    if current_node.left?
      to_array(elements, current_node.left)
    elsif current_node.right?
      to_array(elements, current_node.right)
    end
  end

  private

  def empty?
    root_node.nil?
  end

  def left_of_current_node?(data, current_node)
    data <= current_node.data
  end

  def right_of_current_node?(data, current_node)
    data > current_node.data
  end

  def insert_on_root(data)
    @count += 1
    @root_node = Node.new(data, nil, nil, true)
  end

  def insert_in_tree(data, current_node)
    if left_of_current_node?(data, current_node)
      insert_on_left(data, current_node)
    elsif right_of_current_node?(data, current_node)
      insert_on_right(data, current_node)
    end
  end

  def insert_on_left(data, current_node)
    if current_node.left
      push(data, current_node.left)
    else
      @count += 1
      current_node.left = Node.new(data)
    end
  end

  def insert_on_right(data, current_node)
    if current_node.right
      push(data, current_node.right)
    else
      @count += 1
      current_node.right = Node.new(data)
    end
  end

  def included_in_tree?(data, current_node)
    if current_node.data == data
      true
    else
      check_branches(data, current_node)
    end
  end

  def check_branches(data, current_node)
    if left_of_current_node?(data, current_node) && current_node.left?
      included_in_tree?(data, current_node.left)
    elsif right_of_current_node?(data, current_node) && current_node.right?
      included_in_tree?(data, current_node.right)
    else
      false
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

  def left?
    !left.nil?
  end

  def right?
    !right.nil?
  end
end
