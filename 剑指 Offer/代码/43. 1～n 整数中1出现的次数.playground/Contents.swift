import Foundation
import XCTest

class Solution
{
    /**
     统计从1到N整数中1出现的次数
     解法：遍历1-N，累计过程中每个数字中1出现的计数
     - Parameters:
        - number: 整数N
     - Returns: 1-N 的数十进制表示中1出现的次数
     */
    func numberOf1Between1AndN_Solution1(number: Int) -> Int
    {
        if number <= 0 { return 0 }
        
        // 累计过程中每个数字中1出现的计数
        var totalCount = 0
        
        for i in 1...number
        {
            // 每个数字中1出现的个数
            var count = 0
            var tempNumber = i
            
            while tempNumber > 0
            {
                if tempNumber % 10 == 1
                {
                    count += 1
                }
                tempNumber = tempNumber / 10
            }
            
            totalCount += count
        }
        
        return totalCount
    }
    
    /**
     统计从1到N整数中1出现的次数
     - Parameters:
        - number: 整数N
     - Returns: 1-N 的数十进制表示中1出现的次数
     */
    func numberOf1Between1AndN_Solution2(number: Int) -> Int
    {
        if number <= 0 { return 0 }
        
        return solution2Core(Array(String(number)).map { Int(String($0))! })
    }
    
    // digits: 整数N的各位组成的数组
    private func solution2Core(_ digits: [Int]) -> Int
    {
        // 个位数，1只会出现1次
        if digits.count == 1
        {
            return digits[0] > 0 ? 1 : 0
        }
        
        // numberFirstDigit是数字10000-19999的第一位中1的数目
        var numberFirstDigit = 0
        
        // 首位数字大于1则以10的n次方计算次数
        if digits[0] > 1
        {
            numberFirstDigit = powerBase10(number: digits.count - 1)
        }
        // 首位数字为1
        else if digits[0] == 1
        {
            // 将除首位数字外的剩余位数转换成字符串再连接起来最后再转化为整数后+1
            numberFirstDigit = Int(digits[1...].map(String.init).joined())! + 1
        }
        
        // numOtherDigits 是 01346 - 21345 除了第一位之外的数位中1的数目
        let numberOtherDigits = digits[0] * (digits.count - 1) * powerBase10(number: digits.count - 2)
        
        // numRecursive 是1-1345的数目，用递归求得
        let numberRecursive = solution2Core(Array(digits[1...]))
        
        return numberFirstDigit + numberOtherDigits + numberRecursive
    }
    
    // 计算10的n次方
    private func powerBase10(number: Int) -> Int
    {
        if number < 1 { return 1 }
        
        var result = 1
        for _ in 0 ..< number
        {
            result *= 10
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
        XCTAssertEqual(1, solution.numberOf1Between1AndN_Solution1(number: 1))
        XCTAssertEqual(1, solution.numberOf1Between1AndN_Solution2(number: 1))
    }

    func testCase2()
    {
        XCTAssertEqual(1, solution.numberOf1Between1AndN_Solution1(number: 5))
        XCTAssertEqual(1, solution.numberOf1Between1AndN_Solution2(number: 5))
    }

    func testCase3()
    {
        XCTAssertEqual(2, solution.numberOf1Between1AndN_Solution1(number: 10))
        XCTAssertEqual(2, solution.numberOf1Between1AndN_Solution2(number: 10))
    }
    
    func testCase4()
    {
        XCTAssertEqual(16, solution.numberOf1Between1AndN_Solution1(number: 55))
        XCTAssertEqual(16, solution.numberOf1Between1AndN_Solution2(number: 55))
    }
    
    func testCase5()
    {
        XCTAssertEqual(20, solution.numberOf1Between1AndN_Solution1(number: 99))
        XCTAssertEqual(20, solution.numberOf1Between1AndN_Solution2(number: 99))
    }

    func testCase6()
    {
        XCTAssertEqual(4001, solution.numberOf1Between1AndN_Solution1(number: 10000))
        XCTAssertEqual(4001, solution.numberOf1Between1AndN_Solution2(number: 10000))
    }

    func testCase7()
    {
        XCTAssertEqual(18821, solution.numberOf1Between1AndN_Solution1(number: 21345))
        XCTAssertEqual(18821, solution.numberOf1Between1AndN_Solution2(number: 21345))
    }

    func testCase8()
    {
        XCTAssertEqual(0, solution.numberOf1Between1AndN_Solution1(number: 0))
        XCTAssertEqual(0, solution.numberOf1Between1AndN_Solution2(number: 0))
    }
}

UnitTests.defaultTestSuite.run()

