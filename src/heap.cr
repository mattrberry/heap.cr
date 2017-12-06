require "./heap/*"

module Heap
  extend self

  def push(heap, element)
    heap << element
    siftdown heap, 0, heap.size - 1
  end

  def pop(heap)
    lastelt = heap.pop()
    if heap
      returnitem = heap[0]
      heap[0] = lastelt
      siftup heap, 0
      return returnitem
    end
    return lastelt
  end

  def replace(heap, item)
    returnitem = heap[0]
    heap[0] = item
    siftup heap, 0
    return returnitem
  end

  def pushpop(heap, item)
    if heap and heap[0] < item
      item, heap[0] = heap[0], item
      siftup heap, 0
    end
    return item
  end

  def heapify(x)
    n = x.size
    (0...(n >> 1)).reverse_each do |i|
      siftup x, i
    end
  end

  private def siftdown(heap, startpos, pos)
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

  private def siftup(heap, pos)
    endpos = heap.size
    startpos = posnewitem = pos
    newitem = heap[pos]
    childpos = 2 * pos + 1
    while childpos < endpos
      rightpos = childpos + 1
      if rightpos < endpos && !(heap[childpos] < heap[rightpos])
        childpos = rightpos
      end
      heap[pos] = heap[childpos]
      pos = childpos
      childpos = 2 * pos + 1
    end
    heap[pos] = newitem
    siftdown heap, startpos, pos
  end
end
