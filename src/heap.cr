require "./heap/*"

module Heap
  # TODO Put your code here

  extend self

  def push(heap, element)
    heap << element
    siftdown(heap, 0, heap.size - 1)
  end

  def siftdown(heap, startpos, pos)
    newitem = heap[pos]
    while pos > startpos
      parentpos = (pos - 1) >> 1
      parent = heap[parentpos]
      if newitem < parent
        heap[pos] = parent
        pos = parentpos
        next
      end
      break
    end
    heap[pos] = newitem
  end

end
