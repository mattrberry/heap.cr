require "./spec_helper"

describe Heap do
  describe "valid" do
    it "empty heap" do
      Heap.valid?([] of Float64).should be_true
    end

    it "1 element heap" do
      Heap.valid?([5]).should be_true
    end

    it "reverse sorted heap" do
      Heap.valid?([3, 2, 1]).should be_false
    end

    it "sorted heap" do
      Heap.valid?([1, 2, 3]).should be_true
    end

    it "smaller on right" do
      Heap.valid?([1, 10, 5]).should be_true
    end

    it "all same heap" do
      Heap.valid?([5, 5, 5, 5, 5, 5, 5, 5, 5, 5]).should be_true
    end
  end

  describe "push-pop" do
    it "push 256 random numbers and pop them off, verifying all's okay" do
      heap = [] of Float64
      data = [] of Float64
      Heap.valid?(heap).should be_true
      (0...256).each do |i|
        item = Random.rand
        data << item
        Heap.push(heap, item)
        Heap.valid?(heap).should be_true
      end
      results = [] of Float64
      while heap.size > 0
        item = Heap.pop(heap)
        Heap.valid?(heap).should be_true
        results << item
      end
      data.sort.should eq results
    end
  end

  describe "heapify" do
    it "30 heapifies of growing size" do
      (0...30).each do |size|
        heap = [] of Float64
        (0...size).each do
          heap << Random.rand
        end
        Heap.heapify(heap)
        Heap.valid?(heap).should be_true
      end
    end
  end
end
