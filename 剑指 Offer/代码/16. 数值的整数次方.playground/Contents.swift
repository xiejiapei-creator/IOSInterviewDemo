import Foundation
import XCTest
 
class Solution
{
    /**
     计算base的exponent次幂，exponent为正数
     - Parameters:
     - base：底数
     - exponent: 指数
     - Returns: 如果无法求值，返回nil，否则返回幂指数的结果
     */
    func pow(_ base: Double, exponent: Int) -> Double?
    {
        // 当底数base是零且指数是负数的时候，如果不进行特殊处理，就会出现对0求倒数，从而导致程序运行出错
        if base == 0 && exponent < 0
        {
            return nil
        }
        
        // 当指数为负数的时候，可以先对指数求绝对值，算出次方的结果之后再取倒数
        let absExponent = exponent < 0 ? -exponent : exponent
        var result = powCore(base, exponent: absExponent)
        if exponent < 0
        {
            result = 1 / result
        }
        
        return result
    }
    
    // 核心实现
    func powCore(_ base: Double, exponent: Int) -> Double
    {
        if exponent == 0
        {
            return 1
        }
        
        // 0的n次方最后exponent变为1会返回0
        if exponent == 1
        {
            return base
        }
        
        // 这个公式很容易就能通过递归来实现
        var result = powCore(base, exponent: exponent / 2)
        result *= result
        
        // 我们用右移运算符代替了除以2，用位与运算符代替了求余运算符%来判断一个数是奇数还是偶数
        if exponent % 2 == 1
        {
            // 如果是奇数则还需要把最后一个数字添加进来
            result *= base
        }
        
        return result
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    // 底数2，指数3，结果8
    func testCase1()
    {
        XCTAssertEqual(solution.pow(2, exponent: 3), 8)
    }
    
    // 底数2，指数-3，结果0.125
    func testCase3()
    {
        XCTAssertEqual(solution.pow(2, exponent: -3), 1/8)
    }
    
    // 底数2，指数0，结果1
    func testCase4()
    {
        XCTAssertEqual(solution.pow(2, exponent: 0), 1)
    }
    
    // 底数-2，指数3，结果-8
    func testCase2()
    {
        XCTAssertEqual(solution.pow(-2, exponent: 3), -8)
    }
    
    // 底数0，指数0，结果1
    func testCase5()
    {
        XCTAssertEqual(solution.pow(0, exponent: 0), 1)
    }
    
    // 底数0，指数4，结果0
    func testCase6()
    {
        XCTAssertEqual(solution.pow(0, exponent: 4), 0)
    }
    
    // 底数0，指数-4，结果nil
    func testCase7()
    {
        XCTAssertEqual(solution.pow(0, exponent: -4), nil)
    }
}

UnitTests.defaultTestSuite.run()

