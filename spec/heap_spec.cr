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

  describe "push then pop" do
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

  describe "pushpop" do
    it "on empty" do
      h = [] of Int32
      x = Heap.pushpop(h, 10)
      h.size.should eq 0
      x.should eq 10
    end

    it "favors elements already in heap if equal" do
      h = [] of (Int32 | Float64)
      h << 10
      x = Heap.pushpop(h, 10.0)
      h.size.should eq 1
      h[0].should eq 10
      h[0].should be_a(Int32)
      x.should eq 10.0
      x.should be_a(Float64)
    end

    it "returns item when it is lowest" do
      h = [10]
      x = Heap.pushpop(h, 9)
      h.should eq [10]
      x.should eq 9
    end

    it "properly pops and pushes when item is not lowest" do
      h = [10]
      x = Heap.pushpop(h, 11)
      h.should eq [11]
      x.should eq 10
    end
  end
end
