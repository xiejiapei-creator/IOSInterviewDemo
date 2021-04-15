import Foundation
import XCTest

class Solution
{
    /**
     根据输入数组，返回数组里所有数字拼接起来能排成的最小数字
     - Parameters:
        - numbers: 数组
     - Returns: 最小的数字
     */
    func printMinNumber(_ numbers: [Int]) -> Int?
    {
        if numbers.count == 0 { return nil }
        
        // 将数组中的每个数字拆分成个位数，再统计总个数
        let digitsCount = numbers.reduce(0) { (result, number) in
            result + String(number).count
        }
        
        // 把两个int型的整数拼接起来得到的数字可能会超出int型数字能够表达的范围，从而导致数字溢出
        if digitsCount > 10 { return nil }
        
        // 核心解法：将输入的数字转换成字符串，再将$0和$1进行拼接比较，小的排在前面
        let numbers = numbers.map{ String($0) }.sorted{ return $0 + $1 < $1 + $0 }
        
        // 将排序后的结果连接起来就是最小的数字
        let minNumber = numbers.reduce("", { (result, number) in
            result + number
        })
        
        return Int(minNumber)
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
        XCTAssertEqual(12345, solution.printMinNumber([3,5,1,4,2]))
        XCTAssertEqual(321323, solution.printMinNumber([3,32,321]))
        XCTAssertEqual(321233233, solution.printMinNumber([3655465,323,32123]))
        XCTAssertEqual(111111, solution.printMinNumber([1,11,111]))
        XCTAssertEqual(321, solution.printMinNumber([321]))
    }
}

UnitTests.defaultTestSuite.run()
