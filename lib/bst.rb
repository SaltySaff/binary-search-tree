# frozen_string_literal: true

# creates nodes for BST
class Node
  attr_accessor :data, :left, :right

  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
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

  def test
    puts @root.data
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

array = [1, 2, 9, 3, 4, 5, 6, 7, 8, 9]
tree = Tree.new(array)
tree.pretty_print

# array[array[0...middle].length / 2]
# array[middle + 1..array.length].length / 2
# Node.new(array[middle], array[array[0...middle].length / 2], array[middle + 1..array.length].length / 2)
