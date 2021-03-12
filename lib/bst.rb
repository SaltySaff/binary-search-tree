# frozen_string_literal: true

# creates nodes for BST
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    return @data <=> other.data if other.instance_of? Node

    @data <=> other
  end
end

# creates tree structure for BST
class Tree
  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = array.length / 2
    Node.new(array[middle], build_tree(array[0...middle]), build_tree(array[middle + 1..array.length]))
  end

  def insert(value, node = @root)
    if node.data >= value
      return node.left = Node.new(value, nil, nil) if node.left.nil?

      node = node.left
      insert(value, node)
    elsif node.data < value
      return node.right = Node.new(value, nil, nil) if node.right.nil?

      node = node.right
      insert(value, node)
    end
  end

  def delete(value, node = @root)
    # deletes specified value from the tree
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?
      successor = inorder_successor(node.right)
      node.data = successor.data
      node.right = delete(successor.data, node.right)
    end
    node
  end

  def find(value, node = @root)
    # finds a value in the tree
    return nil if node.nil?

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      node
    end
  end

  def inorder_successor(node = @root)
    # returns node of inorder successor
    node = node.left until node.left.nil?
    node
  end

  def level_order(node = @root, queue = [], array = [])
    return nil if node.nil?

    array.push(node.data)
    queue.push(node.left)
    queue.push(node.right)
    level_order(queue.shift, queue, array)
    array
  end

  def preorder(node = @root, array = [])
    return nil if node.nil?

    array.push(node.data)
    node.left = preorder(node.left, array)
    node.right = preorder(node.right, array)
    array
  end

  def inorder(node = @root, array = [])
    return nil if node.nil?

    node.left = preorder(node.left, array)
    array.push(node.data)
    node.right = preorder(node.right, array)
    array
  end

  def postorder(node = @root, array = [])
    return nil if node.nil?

    node.left = preorder(node.left, array)
    node.right = preorder(node.right, array)
    array.push(node.data)
    array
  end

  def depth(value = nil, node = @root, counter = 0)
    return nil if node.nil?

    if value < node.data
      counter += 1
      height(value, node.left, counter)
    elsif value > node.data
      counter += 1
      height(value, node.right, counter)
    else
      counter
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# array = []
# 100.times do
#   array.push(rand(100))
# end

array = [1, 2, 9, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
tree = Tree.new(array)
tree.pretty_print
p tree.height(13)
