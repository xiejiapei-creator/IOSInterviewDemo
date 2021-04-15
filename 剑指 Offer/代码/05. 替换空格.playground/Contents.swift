import Foundation
import XCTest

class Solution
{
    /**
     替换空格
     - Parameters:
        - string 输入的字符串
     - Returns: 进行替换之后的新字符串
     */
    func replaceSpace(_ string: String) -> String
    {
        var newString: String = ""
        
        for character in string
        {
            if character == " "
            {
                newString.append("%20")
            }
            else
            {
                newString.append(character)
            }
        }
        
        print("进行替换之后的新字符串为：\(newString)")
        return newString
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
    
    // 空格位于字符串的中间且有连续多个空格
    func testCase1()
    {
        XCTAssertEqual(solution.replaceSpace("We are happy."), "We%20are%20happy.")
    }
    
    // 空格位于字符串的最前面和最后面
    func testCase2()
    {
        XCTAssertEqual(solution.replaceSpace(" arehappy "), "%20arehappy%20")
    }
    
    // 输入的字符串中没有空格
    func testCase3()
    {
        XCTAssertEqual(solution.replaceSpace("happy"), "happy")
    }
    
    // 输入的字符串为空字符串
    func testCase4()
    {
        XCTAssertEqual(solution.replaceSpace(""), "")
    }
    
    // 字符串中有连续多个空格
    func testCase5()
    {
        XCTAssertEqual(solution.replaceSpace("   "), "%20%20%20")
    }
}

UnitTests.defaultTestSuite.run()
