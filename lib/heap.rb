class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc || default
    @store = Array.new
  end

  def count
    @store.length
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  def default
    Proc.new do |el1, el2|
      (el1 <=> el2)
    end
  end

  public

  def is_valid?(parent_idx, child_idx, type)
    parent = @store[parent_idx]
    child = @store[child_idx]
    
    if type == 'min'
      parent <= child
    else
      parent >= child
    end
  end

  def swap(parent_idx, type)
    if type == 'min'
      children_indices = child_indices()
    else

    end
  end

  def self.child_indices(len, parent_index)
    #Heaps 3 video 6:40
    children = []

    child1 = (2 * parent_index) + 1
    child2 = (2 * parent_index) + 2

    children << child1 unless child1 >= len
    children << child2 unless child2 >= len

    children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
