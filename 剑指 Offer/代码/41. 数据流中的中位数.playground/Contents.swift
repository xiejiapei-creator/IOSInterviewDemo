
import Foundation
import XCTest

class Solution
{
    /**
     获取数据流中的中位数
     - Parameters:
        - numbers: 数据流
     - Returns: 中位数
     */
    func getMedian(_ numbers: [Double]) -> Double?
    {
        if numbers.count == 0 { return nil }
        
        // 大根堆
        var maxHeap = Heap(sort: { $0 > $1 }, elements: [Double]())
        // 小根堆
        var minHeap = Heap(sort: { $0 < $1 }, elements: [Double]())
        
        // 将数据分别插入到最大堆和最小堆中
        for number in numbers
        {
            // 两个堆的总数和为偶数，需要将数据插入至最小堆
            if (maxHeap.count + minHeap.count) % 2 == 0
            {
                // 如果该数比最大堆的数还要小，则需要先插入最大堆，然后把最大堆的最大数（root）插入到最小堆，否则，直接插入最小堆
                var insertToMinHeap = number
                if maxHeap.count > 0 && number < maxHeap.peek()!
                {
                    insertToMinHeap = maxHeap.peek()!
                    maxHeap.insert(number)
                    maxHeap.remove()
                }
                minHeap.insert(insertToMinHeap)
            }
            // 两个堆的总数和为奇数，需要插入至最大堆
            else
            {
                // 如果该数比最小堆的数还要大，则需要先插入最小堆，然后把最小堆的最小数(root)插入到最大堆，否则直接插入最大堆
                var insertToMaxHeap = number
                if minHeap.count > 0 && number > minHeap.peek()!
                {
                    insertToMaxHeap = minHeap.peek()!
                    minHeap.insert(number)
                    minHeap.remove()
                }
                maxHeap.insert(insertToMaxHeap)
            }
        }
        
        // 开始获取中位数
        let size = minHeap.count + maxHeap.count
        // 如果从数据流中读出偶数个数值，那么中位数就是所有数值排序之后中间两个数的平均值
        if size % 2 == 0
        {
            return (minHeap.peek()! + Double(maxHeap.peek()!)) / 2.0
        }
        // 如果从数据流中读出奇数个数值，那么中位数就是所有数值排序之后位于中间的数值
        else
        {
            return minHeap.peek()
        }
    }
}

class UnitTests: XCTestCase
{
    var solution: Solution!
    
    override func setUp()
    {
        super.setUp()
        solution = Solution()
    }
    
    func testCase1()
    {
        XCTAssertEqual(solution.getMedian([5]), 5)
        XCTAssertEqual(solution.getMedian([5,2]), 3.5)
        XCTAssertEqual(solution.getMedian([5,2,3]), 3)
        XCTAssertEqual(solution.getMedian([5,2,3,4]), 3.5)
        XCTAssertEqual(solution.getMedian([5,2,3,4,1]), 3)
        XCTAssertEqual(solution.getMedian([5,2,3,4,1,6]), 3.5)
        XCTAssertEqual(solution.getMedian([5,2,3,4,1,6,7]), 4)
        XCTAssertEqual(solution.getMedian([5,2,3,4,1,6,7,0]), 3.5)
        XCTAssertEqual(solution.getMedian([5,2,3,4,1,6,7,0,8]), 4)
    }
}

UnitTests.defaultTestSuite.run()



//=========堆结构==============

struct Heap<Element: Equatable>
{
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element])
    {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty
        {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1)
            {
                siftDown(from: i)
            }
        }
    }
    
    var isEmpty: Bool
    {
        elements.isEmpty
    }
    
    var count: Int
    {
        elements.count
    }
    
    func peek() -> Element?
    {
        elements.first
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int
    {
        (2 * index) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int
    {
        (2 * index) + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int
    {
        (index - 1) / 2
    }
}

extension Heap
{
    mutating func remove() -> Element?
    {
        guard !isEmpty else { return nil }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return elements.removeLast()
    }
    
    mutating func siftDown(from index: Int)
    {
        var parent = index
        while true
        {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            if left < count, sort(elements[left], elements[candidate])
            {
                candidate = left
            }
            if right < count, sort(elements[right], elements[candidate])
            {
                candidate = right
            }
            if candidate == parent
            {
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating func insert(_ element: Element)
    {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    mutating func siftUp(from index: Int)
    {
        let child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0, sort(elements[child], elements[parent])
        {
            elements.swapAt(child, parent)
            parent = parentIndex(ofChildAt: child)
        }
    }
    
    mutating func remove(at index: Int) -> Element?
    {
        guard index < elements.count else
        {
            return nil
        }
        if index == elements.count - 1
        {
            return elements.removeLast()
        }
        else
        {
            elements.swapAt(index, elements.count - 1)
            defer
            {
                siftDown(from: index)
                siftDown(from: index)
            }
            return elements.removeLast()
        }
    }
    
    func index(of element: Element, startingAt i: Int) -> Int?
    {
        if i >= count
        {
            return nil
        }
        if sort(element, elements[i])
        {
            return nil
        }
        if element == elements[i]
        {
            return i
        }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i))
        {
            return j
        }
        
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i))
        {
            return j
        }
        return nil
    }
}

func getNthSmallestElement(n: Int, elements: [Int]) -> Int?
{
    var heap = Heap(sort: <, elements: elements)
    var current = 1
    while !heap.isEmpty
    {
        let element = heap.remove()
        if current == n
        {
            return element
        }
        current += 1
    }

    return nil
}



