require_relative 'heap'

def k_largest_elements(array, k)
  answer = []

  array.heap_sort!

  k.times do
    answer.push(array.pop)
  end

  answer
end
