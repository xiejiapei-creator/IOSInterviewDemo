import Foundation
import XCTest

class Solution
{
    /**
     判断5张扑克牌是不是顺子
     解法：将输入的数字排序，统计出0的个数，在从非0数字开始计算当前数字与下一个数字之间的间隙（gap），如果间隙大于0的个数则非顺子，否则为顺子
     - Parameters:
        - nums:数组
     - Returns: 是否顺子
     */
    func isContinuous(_ numbers: [Int]) -> Bool
    {
        guard numbers.count > 0 else { return false }
            
        // 将输入的数字排序
        let numbers = numbers.sorted()
        
        // 统计出0的个数
        let zeroCount = numbers.filter{ $0 == 0 }.count
        
        // 排好序后0一定在前面，需要从非0数字开始计算当前数字与下一个数字之间的间隙（gap）
        var gap = 0
        for index in zeroCount..<numbers.count-1
        {
            // 如果数组中的非0数字重复出现，则该数组不是连续的
            if numbers[index] == numbers[index+1]
            {
                return false
            }
            
            // 计算空缺总数，由于连续数字本身存在1的差距所以每次都需要减去1
            gap += (numbers[index+1] - numbers[index] - 1)
        }
        
        // 如果空缺的总数小于或者等于0的个数，那么这个数组就是连续的，反之则不连续
        return gap > zeroCount ? false : true
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
        let numbers = [1,3,2,5,4]
        XCTAssertEqual(true, solution.isContinuous(numbers))
    }
    
    func testCase2()
    {
        let numbers = [1,3,2,6,4]
        XCTAssertEqual(false, solution.isContinuous(numbers))
    }

    func testCase3()
    {
        let numbers = [0,3,2,6,4]
        XCTAssertEqual(true, solution.isContinuous(numbers))
    }
    func testCase4() {
        let numbers = [0,3,1,6,4]
        XCTAssertEqual(true, solution.isContinuous(numbers))
    }

    func testCase5()
    {
        let numbers = [1,3,0,5,0]
        XCTAssertEqual(true, solution.isContinuous(numbers))
    }

    func testCase6()
    {
        let numbers = [1,3,0,7,0]
        XCTAssertEqual(false, solution.isContinuous(numbers))
    }

    func testCase7()
    {
        let numbers = [1,0,0,5,0]
        XCTAssertEqual(true, solution.isContinuous(numbers))
    }

    func testCase8()
    {
        let numbers = [1,0,0,7,0]
        XCTAssertEqual(false, solution.isContinuous(numbers))
    }

    func testCase9()
    {
        let numbers = [3,0,0,0,0]
        XCTAssertEqual(true, solution.isContinuous(numbers))
    }

    func testCase10()
    {
        let numbers = [0,3,2,6,4]
        XCTAssertEqual(true, solution.isContinuous(numbers))
    }

    func testCase11()
    {
        let numbers = [1,0,0,1,0]
        XCTAssertEqual(false, solution.isContinuous(numbers))
    }

    func testCase12()
    {
        let numbers:[Int] = []
        XCTAssertEqual(false, solution.isContinuous(numbers))
    }
}

UnitTests.defaultTestSuite.run()
