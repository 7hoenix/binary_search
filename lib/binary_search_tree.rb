require 'pry'


class BinarySearchTree
  attr_accessor :root_node
  attr_reader :count

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

  def to_array(current_node=root_node)
    if current_node.nil?
      []
    else
      [current_node.data] + to_array(current_node.left) + to_array(current_node.right)
    end
  end

  def sort(current_node=root_node)
    if current_node.nil?
      []
    else
      sort(current_node.left) + [current_node.data] + sort(current_node.right)
    end
  end

  def min(current_node=root_node, minimum=nil)
    if current_node.nil?
      minimum
    else
      min(current_node.left, current_node.data)
    end
  end

  def max(current_node=root_node, maximum=nil)
    if current_node.nil?
      maximum
    else
      max(current_node.right, current_node.data)
    end
  end

  def post_ordered(current_node=root_node)
    if current_node.nil?
      []
    else
      post_ordered(current_node.left) + post_ordered(current_node.right) + [current_node.data]
    end
  end

  def min_height(current_node=root_node, min_height=0)
    if current_node.nil?
      min_height
    else
      [1 + min_height(current_node.left), 1 + min_height(current_node.right)].min
    end
  end

  def max_height(current_node=root_node, max_height=0)
    if current_node.nil?
      max_height
    else
      [1 + max_height(current_node.left), 1 + max_height(current_node.right)].max
    end
  end

  def balanced?(current_node=root_node, balanced=false)
    if max_height - min_height <= 1
      balanced = true
    else
      balanced
    end
  end

  def balance!
    until balanced?
      if left_heavy?
        rotate_right!
      else
        rotate_left!
      end
    end
  end

  def left_heavy?(current_node=root_node)
    if current_node.left.nil?
      false
    elsif current_node.right.nil?
      true
    else
      (current_node.left.max_height - current_node.right.max_height) > 1
    end
  end

  def rotate_right!
    new_right = @root_node.right.left
    new_root = @root_node.right
    new_root.left = @root_node
    @root_node.right = new_right
    @root_node = new_root
  end

  def rotate_left!
    new_left = @root_node.left.right
    new_root = @root_node.left
    new_root.right = @root_node
    @root_node.left = new_left
    @root_node = new_root
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
    @root_node = Node.new( data: data,
                           root: true )
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
      current_node.left = Node.new(data: data,
                                   parent: current_node)
    end
  end

  def insert_on_right(data, current_node)
    if current_node.right
      push(data, current_node.right)
    else
      @count += 1
      current_node.right = Node.new(data: data,
                                    parent: current_node)
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
                :root,
                :parent

  def initialize(params)
    @data   = params[:data]
    @left   = params[:left]
    @right  = params[:right]
    @root   = params[:root]
    @parent = params[:parent]
  end

  def left?
    !left.nil?
  end

  def right?
    !right.nil?
  end
end
