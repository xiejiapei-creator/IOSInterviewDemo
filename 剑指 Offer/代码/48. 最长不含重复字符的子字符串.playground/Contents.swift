import Foundation
import XCTest

class Solution
{
    /**
     求最长不含重复字符的子字符串
     解法：穷举法，验证所有的子字符串
     - Parameters:
        - string: 字符串
     - Returns: 最长的不包含重复字符的子字符串长度
     */
    func longestSubstringWithoutDuplication_1(_ string: String) -> Int
    {
        // 最长的不包含重复字符的子字符串长度
        var longestSubstringCount = 0
        
        // 将字符串转变为数组
        let characterArray = Array(string)

        // 获取所有的子字符串
        for i in stride(from: 0, through: characterArray.count - 1, by: 1)
        {
            for j in stride(from: i, through: characterArray.count - 1, by: 1)
            {
                if !hasDuplication(String(characterArray[i...j]))
                {
                    // 计算不包含重复字符的子字符串长度
                    let subStringCount = j - i + 1
                    
                    if subStringCount > longestSubstringCount
                    {
                        longestSubstringCount = subStringCount
                    }
                }
            }
        }

        return longestSubstringCount
    }
    
    // 判断字符串中是否包含重复字符
    private func hasDuplication(_ substring: String) -> Bool
    {
        let characterArray = Array(substring)
        var result = [Character]()
        
        for character in characterArray
        {
            if result.contains(character)
            {
                return true
            }
            else
            {
                result.append(character)
            }
        }
        
        return false
    }
    
    /**
     求最长不含重复字符的子字符串
     解法：动态规划
     - Parameters:
        - string: 字符串
     - Returns: 最长的不包含重复字符的子字符串长度
     */
    func longestSubstringWithoutDuplication_2(_ string: String) -> Int
    {
        // 最长的不包含重复字符的子字符串长度
        var longestSubstringCount = 0
        
        // 当前子字符串的长度
        var currentLength = 0
        
        // 记录字符出现过的位置
        var postion = [Character : Int]()
        
        // 将字符串专为字符数组
        let characterArray = Array(string)
        
        // 遍历字符数组，获取当前字符
        for (i, character) in characterArray.enumerated()
        {
            // 获取字符之前出现过的位置
            let prePosition = postion[character]
            
            // 当前字符之前并未出现过 || 当前字符虽然之前出现过，但因为距离太远即时把当前字符拼接到子字符串后面也不会出现重复字符
            if prePosition == nil || (i - prePosition!) > currentLength
            {
                // 把当前字符拼接到子字符串后面，导致最长长度加一
                currentLength += 1
            }
            // 当前字符之前出现过并且距离很短，拼接到后面会导致重复，此时最长长度更新为距离
            else
            {
                // 更新最终长度
                if longestSubstringCount < currentLength
                {
                    longestSubstringCount = currentLength
                }
                
                // 此时最长长度更新为距离
                currentLength = i - prePosition!
            }

            // 当前字符已经出现过，进行记录
            postion[character] = i
        }
        
        return max(longestSubstringCount, currentLength)
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
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("abcacfrar"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("abcacfrar"))
    }
    
    func testCase2()
    {
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("acfrarabc"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("acfrarabc"))
    }

    func testCase3()
    {
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("arabcacfr"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("arabcacfr"))
    }

    func testCase4()
    {
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_1("aaa"))
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_2("aaa"))
    }

    func testCase5()
    {
        XCTAssertEqual(7, solution.longestSubstringWithoutDuplication_1("abcdefg"))
        XCTAssertEqual(7, solution.longestSubstringWithoutDuplication_2("abcdefg"))
    }

    func testCase6()
    {
        XCTAssertEqual(2, solution.longestSubstringWithoutDuplication_1("aaabbbccc"))
        XCTAssertEqual(2, solution.longestSubstringWithoutDuplication_2("aaabbbccc"))
    }

    func testCase7()
    {
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("abcdcba"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("abcdcba"))
    }

    func testCase8()
    {
        XCTAssertEqual(6, solution.longestSubstringWithoutDuplication_1("abcdaef"))
        XCTAssertEqual(6, solution.longestSubstringWithoutDuplication_2("abcdaef"))
    }

    func testCase9()
    {
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_1("a"))
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_2("a"))
    }

    func testCase10()
    {
        XCTAssertEqual(0, solution.longestSubstringWithoutDuplication_1(""))
        XCTAssertEqual(0, solution.longestSubstringWithoutDuplication_2(""))
    }
}

UnitTests.defaultTestSuite.run()

