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
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = array.length / 2
    Node.new(array[middle], build_tree(array[0...middle]), build_tree(array[middle + 1..array.length]))
  end

  def print_tree
    root = @root
    while root
      puts "#{root.data} left is #{root.left.data} right is #{root.right.data}"
      root = root.right
    end
  end
end

array = [1, 2, 9, 3, 4, 5, 6, 7, 8, 9]
tree = Tree.new(array)
p tree

# array[array[0...middle].length / 2]
# array[middle + 1..array.length].length / 2
# Node.new(array[middle], array[array[0...middle].length / 2], array[middle + 1..array.length].length / 2)