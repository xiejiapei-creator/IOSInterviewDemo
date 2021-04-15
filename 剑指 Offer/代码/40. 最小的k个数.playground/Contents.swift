import Foundation
import XCTest

class Solution
{
    /**
     输入n个整数，找出其中最小的k个数
     解法：通过partition的方式找出
     - Parameters:
        - numbers: 数组
        - k: 最小的k个数
     - Returns: 最小的K个数
     */
    func getLeastNumbers_Solution1(_ numbers: [Int], k: Int) -> [Int]
    {
        // 边界处理
        if numbers.count == 0 || k <= 0 || k > numbers.count
        {
            return [Int]()
        }
        
        var numbers = numbers
        var startIndex = 0// 开始位置
        var endIndex = numbers.count - 1// 结束位置
        var partitionIndex = partition(&numbers, start: startIndex, end: endIndex)// 分区位置
        
        // 如果基于数组的第k个数字来调整，则使得比第k个数字小的所有数字都位于数组的左边，比第k个数字大的所有数字都位于数组的右边
        while partitionIndex != k - 1
        {
            if partitionIndex > k - 1
            {
                endIndex = partitionIndex - 1
            }
            else
            {
                startIndex = partitionIndex + 1
            }

            partitionIndex = partition(&numbers, start: startIndex, end: endIndex)
        }
        
        // 返回最小的K个数
        return Array(numbers[0..<k])
    }
    
    /**
     将数组在指定范围内[start，end]分区，使得左边部分数字比右边部分的小
     - Parameters:
        - nums: 数组
        - start: 分区开始索引
        - end: 分区结束索引
     - Returns: index：当前分区的分界索引
     */
    func partition(_ numbers: inout [Int], start: Int, end: Int) -> Int
    {
        // 数组为空或者分区开始索引大于分区结束索引
        if numbers.count == 0 || start >= end
        {
            return start
        }
        
        let pivot = numbers[start]// 以第一个数字作为分区中心点
        var startIndex = start + 1// 开始位置
        var endIndex = end// 结束位置
        
        while true
        {
            // 左边部分数字比中心点小
            while numbers[startIndex] <= pivot && startIndex < end
            {
                startIndex += 1
            }
            
            // 右边部分数字比中心点大
            while numbers[endIndex] > pivot
            {
                endIndex -= 1
            }
            
            // 开始位置和结束位置还未碰头就将左边比中心点大的数字和右边比中心点小的数字进行交换
            if startIndex < endIndex
            {
                (numbers[startIndex], numbers[endIndex]) = (numbers[endIndex], numbers[startIndex])
            }
            // 开始位置和结束位置已经碰头表示分区完成
            else
            {
                // 将中心点交换到分区位置
                (numbers[start], numbers[endIndex]) = (numbers[endIndex], numbers[start])
                
                // 返回分区位置
                return endIndex
            }
        }
    }
    
    /**
     输入n个整数，找出其中最小的k个数
     解法：遍历数组，使用一个最大堆保存最小的k个数（不改变数组，不用一次性全部加载数据，所以适合大数据处理）
     - Parameters:
        - numbers: 数组
        - k: 最小的k个数
     - Returns: 最小的k个数
     */
    func getLeastNumbers_Solution2(_ numbers: [Int], k: Int) -> [Int]
    {
        // 边界处理
        if numbers.count == 0 || k <= 0 || k > numbers.count
        {
            return [Int]()
        }
        
        // 创建一个大小为k的数据容器来存储最小的k个数字
        var heap = Heap(sort: { $0 > $1 }, elements: [Int]())
        
        // 每次从输入的n个整数中读入一个数
        for number in numbers
        {
            // 如果容器中已有的数字少于k个，则直接把这次读入的整数放入容器之中
            // 如果容器中已有k个数字了，也就是容器已满，此时我们不能再插入新的数字而只能替换已有的数字
            if heap.count < k
            {
                heap.insert(number)
                continue
            }
 
            // 找出这已有的k个数中的最大值，然后拿这次待插入的整数和最大值进行比较
            // 如果待插入的值比当前已有的最大值还要大，那么这个数不可能是最小的k个整数之一，于是我们可以抛弃这个整数
            if number < heap.peek()!
            {
                // 如果待插入的值比当前已有的最大值小，则用这个数替换当前已有的最大值
                heap.remove()
                heap.insert(number)
            }
        }
        
        // 返回最小的k个数
        var result = [Int]()
        for _ in 0..<k
        {
            result.append(heap.remove()!)
        }
        return result
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
    
    // k小于数组长度
    func testCase1()
    {
        let nums = [4,5,1,6,2,7,3,8]
        let result1 = solution.getLeastNumbers_Solution1(nums, k: 4).sorted()
        let result2 = solution.getLeastNumbers_Solution2(nums, k: 4).sorted()
        XCTAssertEqual([1,2,3,4], result1)
        XCTAssertEqual([1,2,3,4], result2)
    }

    // k等于数组长度
    func testCase2()
    {
        let nums = [4,5,1,6,2,7,3,8]
        let result1 = solution.getLeastNumbers_Solution1(nums, k: 8).sorted()
        let result2 = solution.getLeastNumbers_Solution2(nums, k: 8).sorted()
        XCTAssertEqual([1,2,3,4,5,6,7,8], result1)
        XCTAssertEqual([1,2,3,4,5,6,7,8], result2)
    }

    // k大于数组长度
    func testCase3()
    {
        let nums = [4,5,1,6,2,7,3,8]
        let result1 = solution.getLeastNumbers_Solution1(nums, k: 10)
        let result2 = solution.getLeastNumbers_Solution2(nums, k: 10)
        XCTAssertEqual([], result1)
        XCTAssertEqual([], result2)
    }

    // k=1
    func testCase4()
    {
        let nums = [4,5,1,6,2,7,3,8]
        let result1 = solution.getLeastNumbers_Solution1(nums, k: 1).sorted()
        let result2 = solution.getLeastNumbers_Solution2(nums, k: 1).sorted()
        XCTAssertEqual([1], result1)
        XCTAssertEqual([1], result2)
    }

    // k=0
    func testCase5()
    {
        let nums = [4,5,1,6,2,7,3,8]
        let result1 = solution.getLeastNumbers_Solution1(nums, k: 0)
        let result2 = solution.getLeastNumbers_Solution2(nums, k: 0)
        XCTAssertEqual([], result1)
        XCTAssertEqual([], result2)
    }

    // 数组中有相同数字
    func testCase6()
    {
        let nums = [4,5,1,6,2,7,3,8]
        let result1 = solution.getLeastNumbers_Solution1(nums, k: 2).sorted()
        let result2 = solution.getLeastNumbers_Solution2(nums, k: 2).sorted()
        XCTAssertEqual([1,2], result1)
        XCTAssertEqual([1,2], result2)
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
