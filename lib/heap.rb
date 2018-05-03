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
    last = (count) - 1
    @store[0], @store[last] = @store[last], @store[0]
    popped = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count)
    popped
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, (count) - 1, count)
  end

  def default
    Proc.new do |el1, el2|
      (el1 <=> el2)
    end
  end

  public

  # def is_valid?(parent_idx, child_idx, type = 'min')
  #   parent = @store[parent_idx]
  #   child = @store[child_idx]
  #
  #   if type == 'min'
  #     parent <= child
  #   else
  #     parent >= child
  #   end
  # end
  #
  # def swap(parent_idx)
  #   children_indices = child_indices(count, parent_idx)
  #
  #   parent = @store[parent_idx]
  #   child1 = @store[children_indices[0]] || nil
  #   child2 = @store[children_indices[1]] || nil
  #
  #   if @prc.call(parent, child1) == -1
  #     @store[parent_idx], @store[child_indices[0]] = @store[child_indices[0]], @store[parent_idx]
  #   elsif @prc.call(parent, child2) == -1
  #     @store[parent_idx], @store[child_indices[1]] = @store[child_indices[1]], @store[parent_idx]
  #   end
  # end

  # def find_smaller()
  #
  # end

  def self.child_indices(len, parent_index)
    #Heaps 3 video 6:40
    children = []

    child1 = (2 * parent_index) + 1
    child2 = (2 * parent_index) + 2

    children << child1 unless child1 >= len || child1.nil?
    children << child2 unless child2 >= len || child2.nil?

    children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    if prc.nil?
      prc = Proc.new do |el1, el2|
        (el1 <=> el2)
      end
    end

    parent_idx.upto(len - 1) do |idx|
      children_indices = child_indices(len, idx)

      parent = array[idx]
      child1 = nil
      child2 = nil

      if children_indices.empty?
        next
      elsif children_indices.length == 1
        child1 = array[children_indices[0]]
      elsif children_indices.length == 2
        child1 = array[children_indices[0]]
        child2 = array[children_indices[1]]
      end

      if (!child1.nil? && prc.call(parent, child1) == 1) && (child2.nil? || prc.call(child1, child2) != 1)
        array[idx], array[children_indices[0]] = array[children_indices[0]], array[idx]
      elsif !child2.nil? && prc.call(parent, child2) == 1
        array[idx], array[children_indices[1]] = array[children_indices[1]], array[idx]
      end
    end

    array
  end



  def self.heapify_up(array, child_idx, len = array.length, &prc)
    if prc.nil?
      prc = Proc.new do |el1, el2|
        (el1 <=> el2)
      end
    end

    heaped = false
    target_idx = child_idx

    until heaped || target_idx == 0
      parent_idx = parent_index(target_idx)
      parent = array[parent_idx]
      child = array[target_idx]

      if prc.call(parent, child) == 1
        array[parent_idx], array[target_idx] = array[target_idx], array[parent_idx]
        target_idx = parent_idx
      else
        heaped = true
      end
    end

    array
  end
end
