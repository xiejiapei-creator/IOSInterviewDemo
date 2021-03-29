import Foundation
import XCTest

class Solution
{
    /**
     动态规划算法：长度为n的绳子剪成m段后的最大乘积
     - Parameters:
        - length: 绳子长度
     - Returns: 最大乘积
     */
    func maxProductAfterCutting_dynamicSolution(ropeLength: Int) -> Int
    {
        // 绳子长度为1时只能剪成1和0  1*0 = 0
        // 绳子长度为2时只能剪成1和1  1*1 = 1
        // 绳子长度为3时能剪成1和2 或者 3个1  1*2 > 1*1*1 = 2
        if ropeLength < 4
        {
            return ropeLength - 1
        }
        
        // 子问题的最优解存储在数组products里
        // 不能写出[0, 0, 1, 2]，否则当j=1时候，f(j)=0，导致结果全部为0，所以这里将1、2、3全都后移了一位
        var products = [0, 1, 2, 3]
        var max = 0
        for i in 4...ropeLength
        {
            // 求解每个f(i)都需要将之前的最大值清空为0
            max = 0
            
            // 为了求解f(i)，我们需要求出所有可能的f(j)xf(i-j)并比较得出它们的最大值
            // i/2: 因为是将线段划分为两半，所以只需要求解前面一半即可
            for j in 1...i/2
            {
                let productMultiplicationValue = products[j] * products[i-j]
                if productMultiplicationValue > max
                {
                    max = productMultiplicationValue
                }
            }
            
            // 将结果保存在products里
            products.append(max)
        }
        
        // 从数组中返回我们需要的结果
        return products[ropeLength]
    }
    
    /**
     贪心算法：尽可能多地减去长度为3的绳子段，当绳子最后剩下的长度为4的时候剪成2段
     - Parameters:
        - length: 绳子长度
     - Returns: 段数的最大乘积
     */
    func maxProductAfterCutting_greedySolution(ropeLength: Int) -> Int
    {
        // 原因同上
        if ropeLength < 4
        {
            return ropeLength - 1
        }
        
        // 下面是用数学方式证明所得的计算公式
        if ropeLength % 3 == 1
        {
            return Int(truncating: (pow(3, ropeLength / 3 - 1) * 4) as NSDecimalNumber)
        }
        else if ropeLength % 3 == 0
        {
            return Int(truncating: (pow(3, ropeLength / 3)) as NSDecimalNumber)
        }
        else
        {
            return Int(truncating: (pow(3, ropeLength / 3) * 2) as NSDecimalNumber)
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
    
    // 绳子长度为1
    func testCase1()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 1), 0)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 1), 0)
    }
    
    // 长度为2
    func testCase2()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 2), 1)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 2), 1)
    }
    
    //长度为3
    func testCase3()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 3), 2)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 3), 2)
    }
    
    //长度为4
    func testCase4()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 4), 4)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 4), 4)
    }
    
    //长度为5
    func testCase5()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 5), 6)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 5), 6)
    }
    
    //长度为6
    func testCase6()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 6), 9)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 6), 9)
    }
    
    // 长度为7
    func testCase7()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 7), 12)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 7), 12)
    }
    
    // 长度为8
    func testCase8()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 8), 18)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 8), 18)
    }
    
    // 长度为9
    func testCase9()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 9), 27)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 9), 27)
    }
    
    // 长度为10
    func testCase10()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 10), 36)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 10), 36)
    }
    
    // 长度为50
    func testCase11()
    {
        XCTAssertEqual(solution.maxProductAfterCutting_dynamicSolution(ropeLength: 50), 86093442)
        XCTAssertEqual(solution.maxProductAfterCutting_greedySolution(ropeLength: 50), 86093442)
    }
}

UnitTests.defaultTestSuite.run()

 


