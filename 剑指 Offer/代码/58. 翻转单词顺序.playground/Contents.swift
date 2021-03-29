import Foundation
import XCTest

class Solution
{
    /**
     翻转单词顺序
     - Parameters:
        - sentence: 翻转前的句子
     - Returns: 翻转之后的句子
     */
    func reverseSentence(_ sentence: String) -> String
    {
        var characters: [Character] = Array(sentence)
        
        // 第一步翻转句子中所有的字符：此时不但翻转了句子中单词的顺序，连单词内的字符顺序也被翻转了
        characters.reverse()

        // 可以通过扫描空格来确定每个单词的起始和终止位置
        let words = characters.split(separator: " ")

        // 字符串为空" "，此时words为[]，数量为0，直接返回" "，否则最后一步移除空格后变为""
        guard words.count > 0 else { return String(characters) }

        // 第二步再翻转每个单词中字符的顺序，最后将翻转后的单词字符串拼接起来
        var result = words.reduce("") {
            $0 + $1.reversed() + " "
        }
 
        // 去掉翻转句子中的最后一个空格
        if result.count > 0
        {
            result.removeLast()
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
    
    // 多个单词
    func testCase1()
    {
        let data = "I am a student."
        XCTAssertEqual("student. a am I", solution.reverseSentence(data))
    }

    // emoji
    func testCase2()
    {
        let data = "I ❤️ you."
        XCTAssertEqual("you. ❤️ I", solution.reverseSentence(data))
    }

    // 只有一个单词
    func testCase3()
    {
        let data = "Wonderful"
        XCTAssertEqual("Wonderful", solution.reverseSentence(data))
    }

    // 空字符串
    func testCase4()
    {
        let data = ""
        XCTAssertEqual("", solution.reverseSentence(data))
    }

    // 空格
    func testCase5()
    {
        let data = " "
        XCTAssertEqual(data, solution.reverseSentence(data))
    }
}

UnitTests.defaultTestSuite.run()



