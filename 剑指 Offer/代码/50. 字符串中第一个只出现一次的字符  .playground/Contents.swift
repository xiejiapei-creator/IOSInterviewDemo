import Foundation
import XCTest

class Solution
{
    /**
     查找字符串中第一个只出现一次的字符
     解法：利用字典存储各个字符的出现次数
     - Parameters:
        - string: 输入的字符串
     - Returns: 第一个不重复的字符
     */
    func getFirstNotRepeatingCharacter(_ string: String) -> Character?
    {
        // 利用字典存储各个字符的出现次数
        var dictionary = [Character : Int]()
        
        // 将字符串转化为字符数组
        let characterArray = Array(string)
        
        // 遍历字符数组统计字符出现次数
        for character in characterArray
        {
            // 字符第一次出现
            if dictionary[character] == nil
            {
                dictionary[character] = 1
            }
            // 字符又出现了一次
            else
            {
                dictionary[character]! += 1
            }
        }
        
        // 查找字符串中第一个只出现一次的字符
        for character in characterArray
        {
            if dictionary[character] == 1
            {
                return character
            }
        }
        
        return nil
    }
}

class UnitTests: XCTestCase
{
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    func testCase1()
    {
        XCTAssertEqual("l", solution.getFirstNotRepeatingCharacter("google"))
    }
    
    func testCase2()
    {
        XCTAssertEqual(nil, solution.getFirstNotRepeatingCharacter("aabccdbd"))
    }
    
    func testCase3()
    {
        XCTAssertEqual("a", solution.getFirstNotRepeatingCharacter("abcdefg"))
    }
}

UnitTests.defaultTestSuite.run()
