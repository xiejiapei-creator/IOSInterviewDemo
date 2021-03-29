import Foundation
import XCTest

class Solution
{
    /**
    返回数组中只出现一次的数字
     - Parameters:
        - array: 数组
     - Returns: 出现一次的数字
     */
    func findNumberAppearingOnce(_ array: [Int]) -> Int?
    {
        guard array.count > 0 else { return nil }
            
        // 我们需要一个长度为32的辅助数组存储二进制表示的每位的和
        // 原数组为：[1, 1, 1, 2, 2, 2, 3]，辅助数组：[0,...0]
        var bitSum = Array(repeating: 0, count: Int.bitWidth)
        
        array.forEach
        {
            var bitMask = 1
            
            for i in 0..<Int.bitWidth
            {
                // 进入循环体：$0=1，bitMask=1，bit=1
                let bit = $0 & bitMask
                
                // 辅助数组：[1, 0,...0]
                bitSum[i] += bit == 0 ? 0 : 1
                
                // 左移一位：2
                bitMask = bitMask << 1
            }
        }
        
        var result = 0
        for i in stride(from: Int.bitWidth - 1, through: 0, by: -1)
        {
            result = result << 1
            
            // 如果某一位的和能被3整除，那么那个只出现一次的数字二进制表示中对应的那一位是0，否则就是1
            // 如果某一位的和能被3整除，result=3，bitSum[i]=4
            result += bitSum[i] % 3
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
    
    func testCase1()
    {
        let numbers = [1,1,1,2,2,2,3]
        XCTAssertEqual(3, solution.findNumberAppearingOnce(numbers))
    }
    
    func testCase2()
    {
        let numbers = [4, 3, 3, 2, 2, 2, 3]
        XCTAssertEqual(4, solution.findNumberAppearingOnce(numbers))
    }

    func testCase3()
    {
        let numbers = [4,4,1,1,1,7,4]
        XCTAssertEqual(7, solution.findNumberAppearingOnce(numbers))
    }

    func testCase4()
    {
        let numbers = [-10,214,214,214]
        XCTAssertEqual(-10, solution.findNumberAppearingOnce(numbers))
    }

    func testCase5()
    {
        let numbers = [-209, 3467, -209, -209]
        XCTAssertEqual(3467, solution.findNumberAppearingOnce(numbers))
    }

    func testCase6()
    {
        let numbers = [1024, -1025, 1024, -1025, 1024, -1025, 1023]
        XCTAssertEqual(1023, solution.findNumberAppearingOnce(numbers))
    }

    func testCase7()
    {
        let numbers = [-1024, -1024, -1024, -1023]
        XCTAssertEqual(-1023, solution.findNumberAppearingOnce(numbers))
    }

    func testCase8()
    {
        let numbers = [-23, 0, 214, -23, 214, -23, 214]
        XCTAssertEqual(0, solution.findNumberAppearingOnce(numbers))
    }

    func testCase9()
    {
        let numbers = [0,3467,0,0,0,0,0,0]
        XCTAssertEqual(3467, solution.findNumberAppearingOnce(numbers))
    }
}

UnitTests.defaultTestSuite.run()
