import Foundation
import XCTest

class Solution
{
    
    /**
     左旋转字符串
     - Parameters:
        - content: 字符串
        - n: 左旋转的字符个数
     - Returns: 左旋转之后的字符串
     */
    func leftRotateString(_ content: String, _ n: Int) -> String
    {
        guard n > 0 && n < content.count else { return content }
        
        // 将字符串按照左旋转的字符个数进行分组
        let content = Array(content)
        let leftContent = Array(content[0..<n])
        var rightContent = Array(content[n...])
        
        // 将左边的挪动到后面即可
        rightContent.append(contentsOf: leftContent)
        
        return String(rightContent)
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
        let content = "abcdefg"
        XCTAssertEqual("bcdefga", solution.leftRotateString(content, 1))
    }
    
    func testCase2()
    {
        let content = "abcdefg"
        XCTAssertEqual("cdefgab", solution.leftRotateString(content, 2))
    }
    
    func testCase4()
    {
        let content = "abcdefg"
        XCTAssertEqual("gabcdef", solution.leftRotateString(content, 6))
    }

    func testCase5()
    {
        let content = "abcdefg"
        XCTAssertEqual("abcdefg", solution.leftRotateString(content, 0))
    }

    func testCase6()
    {
        let content = "abcdefg"
        XCTAssertEqual("abcdefg", solution.leftRotateString(content, 7))
    }
}

UnitTests.defaultTestSuite.run()
