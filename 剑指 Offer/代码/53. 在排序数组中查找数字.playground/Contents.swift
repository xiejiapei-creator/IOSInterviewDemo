import Foundation
import XCTest

class Solution
{
    /**
     统计数字在排序数组中出现的次数
     解法：利用二分法分别查找连续出现数字的第一个和最后一个位置，根据两个位置可得出出现次数
     - Parameters:
        - data: 排序数组
        - k：查找的数字
     - Returns: 在数组中出现的次数
     */
    func getNumberOfK(data: [Int], k: Int) -> Int
    {
        guard data.count > 0 else { return 0 }
        
        // 第一次出现数字k的位置
        let firstKIndex = getFirstK(data: data, k: k, startIndex: 0, endIndex: data.endIndex - 1)
        
        // 最后一次出现数字k的位置
        let lastKIndex = getLastK(data: data, k: k, startIndex: 0, endIndex: data.endIndex - 1)

        // k在数组中出现的次数
        if firstKIndex != -1 && lastKIndex != -1
        {
            return lastKIndex - firstKIndex + 1// index从0开始计数
        }

        return 0
    }
    
    /**
    查找排序数组[startIndex,endIndex]范围内第一次出现数字k的位置
    - Parameters:
       - data: 排序数组
       - k：查找的数字
       - startIndex：开始查找的位置
       - endIndex: 结束查找的位置
    - Returns: 在数组中第一次出现的位置（没有出现就返回-1）
    */
    private func getFirstK(data: [Int], k: Int, startIndex: Int, endIndex: Int) -> Int
    {
        //print("查找排序数组[startIndex \(startIndex),endIndex \(endIndex)]范围内第一次出现数字k的位置")
        
        // 递归结束条件
        guard endIndex >= startIndex else { return -1 }
        
        // 二分查找算法总是先拿数组中间的数字和k作比较
        var startIndex = startIndex, endIndex = endIndex
        let midIndex = (startIndex + endIndex ) / 2
        
        // 如果中间的数字比k大，那么k只有可能出现在数组的前半段，下一轮我们只在数组的前半段查找就可以了
        if data[midIndex] > k
        {
            endIndex = midIndex - 1
        }
        // 如果中间的数字比k小， 那么k只有可能出现在数组的后半段，下一轮我们只在数组的后半段查找就可以了
        else if data[midIndex] < k
        {
            startIndex = midIndex + 1
        }
        // 如果中间的数字和k相等呢？
        else
        {
            // 如果中间数字的前面一个数字不是k，那么此时中间的数字刚好就是第一个k
            if midIndex > 0 && data[midIndex - 1] != k
            {
                return midIndex
            }
            // 因为 midIndex - 1，所以需要判断 midIndex 为0的情况，当为0的时候说明第一个k在数组首位置出现
            // 虽然都是直接返回 midIndex，但需要单独列出来，否则 midIndex - 1 造成数组越界导致崩溃
            else if midIndex == 0
            {
                return midIndex
            }
            // 如果中间数字的前面一个数字也是k，那么第一个k肯定在数组的前半段，下一轮我们仍然需要在数组的前半段查找
            else
            {
                endIndex = midIndex - 1
            }
        }
        
        // 递归：继续进行二分查找
        return getFirstK(data: data, k: k, startIndex: startIndex, endIndex: endIndex)
    }
    
    /**
     查找排序数组[startIndex,endIndex]范围内最后一次出现数字k的位置
     - Parameters:
        - data: 排序数组
        - k：查找的数字
        - startIndex：开始查找的位置
        - endIndex: 结束查找的位置
     - Returns: 在数组中最后一次出现的位置（没有出现就返回-1）
     */
    private func getLastK(data: [Int], k: Int, startIndex: Int, endIndex: Int) -> Int
    {
        guard endIndex >= startIndex else { return -1 }
        
        var startIndex = startIndex, endIndex = endIndex
        let midIndex = (startIndex + endIndex ) / 2
        
        if data[midIndex] > k
        {
            endIndex = midIndex - 1
        }
        else if data[midIndex] < k
        {
            startIndex = midIndex + 1
        }
        else
        {
            // 如果中间数字正好在在数组末尾，则直接返回midIndex
            if midIndex == data.count - 1
            {
                return midIndex
            }
            // 如果中间数字的后面一个数字不是k，那么此时中间的数字刚好就是最后一个k
            else if midIndex > 0 && data[midIndex + 1] != k
            {
                return midIndex
            }
            // 如果中间数字的后面一个数字也是k，那么最后一个k肯定在数组的后半段，下一轮我们仍然需要在数组的后半段查找
            else
            {
                startIndex = midIndex + 1
            }
        }
        
        return getLastK(data: data, k: k, startIndex: startIndex, endIndex: endIndex)
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
    
    // 查找的数字出现在数组的中间
    func testCase1()
    {
        let data = [1,2,3,3,3,3,4,5]
        XCTAssertEqual(4, solution.getNumberOfK(data: data, k: 3))
    }

    // 查找的数字出现在数组的开头
    func testCase2()
    {
        let data = [3,3,3,3,4,5]
        XCTAssertEqual(4, solution.getNumberOfK(data: data, k: 3))
    }

    // 查找的数字出现在数组的结尾
    func testCase3()
    {
        let data = [1,2,3,3,3,3]
        XCTAssertEqual(4, solution.getNumberOfK(data: data, k: 3))
    }

    // 查找的数字不存在
    func testCase4()
    {
        let data = [1,3,3,3,3,4,5]
        XCTAssertEqual(0, solution.getNumberOfK(data: data, k: 2))
    }

    // 查找的数字比第一个数字还小，不存在
    func testCase5()
    {
        let data = [1,2,3,3,3,3,4,5]
        XCTAssertEqual(0, solution.getNumberOfK(data: data, k: 0))
    }

    // 查找的数字比最后一个数字还大，不存在
    func testCase6()
    {
        let data = [1,2,3,3,3,3,4,5]
        XCTAssertEqual(0, solution.getNumberOfK(data: data, k: 6))
    }

    // 数组中的数字从头到尾都是查找的数字
    func testCase7()
    {
        let data = [3,3,3,3]
        XCTAssertEqual(4, solution.getNumberOfK(data: data, k: 3))
    }

    // 数组中的数字从头到尾只有一个重复的数字，不是查找的数字
    func testCase8()
    {
        let data = [3,3,3,3]
        XCTAssertEqual(0, solution.getNumberOfK(data: data, k: 4))
    }

    // 数组中只有一个数字，是查找的数字
    func testCase9()
    {
        let data = [3]
        XCTAssertEqual(1, solution.getNumberOfK(data: data, k: 3))
    }

    // 数组中只有一个数字，不是查找的数字
    func testCase10()
    {
        let data = [3]
        XCTAssertEqual(0, solution.getNumberOfK(data: data, k: 4))
    }
}

UnitTests.defaultTestSuite.run()

 
 
