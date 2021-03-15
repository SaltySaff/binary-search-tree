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
  attr_accessor :array, :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    # builds a BST from an array
    return nil if array.empty?

    middle = array.length / 2
    Node.new(array[middle], build_tree(array[0...middle]), build_tree(array[middle + 1..array.length]))
  end

  def insert(value, node = @root)
    # inserts a new value in to the tree
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
    # prints each node in breadth-first level order
    return node if node.nil?

    array.push(node.data)
    queue.push(node.left) unless node.left == nil
    queue.push(node.right) unless node.right == nil
    level_order(queue.shift, queue, array)
    array
  end

  def preorder(node = @root, array = [])
    # prints each node in depth-first preorder
    return nil if node.nil?

    array.push(node.data)
    preorder(node.left, array)
    preorder(node.right, array)
    array
  end

  def inorder(node = @root, array = [])
     # prints each node in depth-first inorder
    return nil if node.nil?

    inorder(node.left, array)
    array.push(node.data)
    inorder(node.right, array)
    array
  end

  def postorder(node = @root, array = [])
     # prints each node in depth-first postorder
    return nil if node.nil?

    postorder(node.left, array)
    postorder(node.right, array)
    array.push(node.data)
    array
  end

  def depth(value = nil, node = @root, counter = 0)
     # returns the depth of the specified node in the tree
    return nil if node.nil?

    if value < node.data
      counter += 1
      depth(value, node.left, counter)
    elsif value > node.data
      counter += 1
      depth(value, node.right, counter)
    else
      counter
    end
  end

  def height(node = @root)
    # returns the height of the specified node in the tree
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def balanced?(node = @root)
    # checks if the tree is balanced
    (height(node.left) - height(node.right)).abs > 1 ? false : true
  end

  def rebalance(node = @root)
    # rebalances the tree
    array = level_order(node)
    array = array.sort
    Tree.new(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    # prints the tree in the terminal
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# driver code
tree = Tree.new(array = Array.new(15) { rand(1..100 )})
tree = Tree.new(array)

tree.pretty_print

puts "Balanced: #{tree.balanced?}"
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Inorder: #{tree.inorder}"
puts "Postorder: #{tree.postorder}"

tree.insert(100)
tree.insert(1000)
tree.insert(10000)
tree.insert(100000)
tree.pretty_print

puts "Balanced: #{tree.balanced?}"

tree = tree.rebalance

tree.pretty_print

puts "Balanced: #{tree.balanced?}"

puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Inorder: #{tree.inorder}"
puts "Postorder: #{tree.postorder}"



