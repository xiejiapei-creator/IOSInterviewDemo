import Foundation
import XCTest

class Solution
{
    /**
     滑动窗口的最大值
     - Parameters:
        - numbers: 数组
        - size: 滑动窗口大小
     - Returns: 所有滑动窗口里的最大值
     */
    func maxInWindows(_ numbers: [Int], _ size: Int) -> [Int]
    {
        // 滑动窗口的最大值
        var maxInWindows = [Int]()
        
        // 最大值队列：需要用两端开口的队列来保存有可能是滑动窗口最大值的数字的下标
        var maxQueue = [Int]()
        
        // 输入的数组大小需要大于滑动窗口大小
        guard numbers.count >= size && size > 0 else { return maxInWindows }
            
        // 将第一个滑动窗口的值添加到队列中
        for index in 0..<size
        {
            // 判断最大值队列里已有数字是否小于待存入的数字
            while maxQueue.count > 0 && numbers[index] > numbers[maxQueue.last!]
            {
                // 如果已有的数字小于待存入的数字，那么这些数字已经不可能是滑动窗口的最大值，因此它们将会被依次从队列的尾部删除
                maxQueue.removeLast()
            }
            
            // 这里存储的是最大值的下标，因为后续要根据下标来判断是否需要删除数值
            maxQueue.append(index)
        }
        
        // 处理其他滑动窗口
        for index in size..<numbers.count
        {
            // 最大值队列的队首就是窗口中的最大值，将其放入到结果数组中
            maxInWindows.append(numbers[maxQueue.first!])
             
            // 判断最大值队列里已有数字是否小于待存入的数字，有则删除
            while maxQueue.count > 0 && numbers[index] > numbers[maxQueue.last!]
            {
                maxQueue.removeLast()
            }
            
            // maxQueue.first! - index >= size
            // 如果队列头部的数字已经从窗口里滑出， 那么滑出的数字也需要从队列的头部删除
            // 当一个数字的下标与滑动窗口的大小之和小于或者等于当前处理的数字的下标时，这个数字已经从窗口中滑出，可以从队列中删除了
            if maxQueue.count > 0 && maxQueue.first! + size <= index
            {
                maxQueue.removeFirst()
            }
            
            // 这里存储的是最大值的下标
            maxQueue.append(index)
        }
        
        // 最大值队列的队首就是窗口中的最大值，将其放入到结果数组中
        maxInWindows.append(numbers[maxQueue.first!])
        
        return maxInWindows
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
       let nums = [2,3,4,2,6,2,5,1]
       let expected = [4,4,6,6,6,5]
       XCTAssertEqual(expected, solution.maxInWindows(nums, 3))
   }
   
   func testCase2()
   {
       let nums = [1,3,-1,-3,5,3,6,7]
       let expected = [3,3,5,5,6,7]
       XCTAssertEqual(expected, solution.maxInWindows(nums, 3))
   }

   func testCase3()
   {
       let nums = [1, 3, 5, 7, 9, 11, 13, 15]
       let expected = [7, 9, 11, 13, 15]
       XCTAssertEqual(expected, solution.maxInWindows(nums, 4))
   }

   func testCase4()
   {
       let nums = [16, 14, 12, 10, 8, 6, 4]
       let expected = [16, 14, 12]
       XCTAssertEqual(expected, solution.maxInWindows(nums, 5))
   }

   func testCase5()
   {
       let nums = [10,14,12,11]
       let expected = [10,14,12,11]
       XCTAssertEqual(expected, solution.maxInWindows(nums, 1))
   }

   func testCase6()
   {
       let nums = [10,14,12,11]
       let expected = [14]
       XCTAssertEqual(expected, solution.maxInWindows(nums, 4))
   }

   func testCase7()
   {
       let nums = [10,14,12,11]
       let expected:[Int] = []
       XCTAssertEqual(expected, solution.maxInWindows(nums, 0))
   }

   func testCase8()
   {
       let nums = [10,14,12,11]
       let expected:[Int] = []
       XCTAssertEqual(expected, solution.maxInWindows(nums, 5))
   }

   func testCase9()
   {
       let nums:[Int] = []
       let expected:[Int] = []
       XCTAssertEqual(expected, solution.maxInWindows(nums, 5))
   }
}

UnitTests.defaultTestSuite.run()
