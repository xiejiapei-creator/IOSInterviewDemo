import Foundation
import XCTest

class Solution
{
    /**
     返回该字符串中字符的所有排列
     - Parameters:
        - string: 输入的字符串
     - Returns: 字符所有可能的排列
     */
    func permutation(_ string: String) -> [String]
    {
        // 将字符串转变为字符数组
        let characters = Array(string)
        
        // 如果为空字符串则直接返回
        if characters.count == 0
        {
            return []
        }
        
        // 调用核心实现，返回该字符串中字符的所有排列
        var result = [String]()
        permutationCore(characters, startIndex: 0, result: &result)
        return result
    }
    
    /**
     返回该字符串中字符的所有排列
     - Parameters:
        - characters: 字符数组
        - startIndex: 开始排列的数组索引
     - Returns: 字符所有可能的排列
     */
    private func permutationCore(_ characters:[Character], startIndex: Int, result: inout [String])
    {
        var characters = characters
        
        // 排列完毕
        if startIndex == characters.count
        {
            // 将当前这种排列组合方式添加到结果数组中
            result.append(String(characters))
        }
        else
        {
            // 将startIndex位置的字符和后面所有字符依次进行交换，得到每一种排列组合方式
            for index in startIndex ..< characters.count// 0 1 -> 1
            {
                // 交换
                (characters[index], characters[startIndex]) = (characters[startIndex], characters[index])
                
                // 针对每次交换结果进行递归处理
                permutationCore(characters, startIndex: startIndex + 1, result: &result)
                
                // 复原
                (characters[index], characters[startIndex]) = (characters[startIndex], characters[index])
            }
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
        let result = solution.permutation("")
        XCTAssertEqual([], result)
    }

    func testCase2()
    {
        let result = solution.permutation("a")
        XCTAssertEqual(["a"], result)
    }
    
    func testCase3()
    {
        let result = solution.permutation("ab")
        XCTAssertEqual(["ab","ba"], result)
    }
    
    func testCase4()
    {
        let result = solution.permutation("abc")
        XCTAssertEqual(["abc","acb","bac","bca","cba","cab"], result)
    }
}

UnitTests.defaultTestSuite.run()

