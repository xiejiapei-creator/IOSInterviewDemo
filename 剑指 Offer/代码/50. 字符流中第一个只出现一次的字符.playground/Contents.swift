import Foundation
import XCTest

class Solution
{
    // 定义一个数据容器来保存字符在字符流中的位置
    private var dictionary = [Character : Int]()
    
    // 向字符流中插入字符的位置
    private var index = 0
    
    /**
     返回第一个不重复的字符
     解法：利用字典存储各个字符的出现次数
     - Returns: 第一个不重复的字符
     */
    func getFirstNotRepeatingChar() -> Character?
    {
        // 只需要扫描整个数组，并从中找出最小的大于等于0的值对应的字符即可
        return dictionary.filter{ $0.value >= 0 }.min{ a, b in a.value < b.value }?.key
    }
    
    // 向字符流中插入字符
    func insertCharacter(_ character: Character)
    {
        // 当一个字符第一次从字符流中读出来时，把它在字符流中的位置保存到数据容器里
        if dictionary[character] == nil
        {
            dictionary[character] = index
        }
        // 当这个字符再次从字符流中读出来时，那么它就不是只出现一次的字符，也就可以被忽略了
        else
        {
            // 这时把它在数据容器里保存的值更新成一个特殊的值 (如负数值)
            dictionary[character] = -1
        }
        
        // 插入到下一个位置
        index += 1
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
        // g：第一个只出现一次的字符是 g
        solution.insertCharacter("g")
        XCTAssertEqual("g", solution.getFirstNotRepeatingChar())
        
        // go：第一个只出现一次的字符是 g
        solution.insertCharacter("o")
        XCTAssertEqual("g", solution.getFirstNotRepeatingChar())
        
        // goo：第一个只出现一次的字符是 g
        solution.insertCharacter("o")
        XCTAssertEqual("g", solution.getFirstNotRepeatingChar())

        // goog：第一个只出现一次的字符是 nil（两个字符都重复了）
        solution.insertCharacter("g")
        XCTAssertEqual(nil, solution.getFirstNotRepeatingChar())

        // googl：第一个只出现一次的字符是 l
        solution.insertCharacter("l")
        XCTAssertEqual("l", solution.getFirstNotRepeatingChar())

        // google：第一个只出现一次的字符是 l
        solution.insertCharacter("e")
        XCTAssertEqual("l", solution.getFirstNotRepeatingChar())
    }
}

UnitTests.defaultTestSuite.run()
