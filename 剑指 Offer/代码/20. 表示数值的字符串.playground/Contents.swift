import Foundation
import XCTest

class Solution
{
    private let digits: [Character] = ["0","1","2","3","4","5","6","7","8","9"]
    
    /**
     数字的格式可以用A[.[B]][e|EC]或者.B[e|EC]表示，其中A和C都是整数（可以有正负号，也可以没有），而B是一个无符号整数
     - Parameters:
        - str: 字符串
     - Returns: 字符串是否可以表示数值
     */
    func isNumeric(str: String) -> Bool
    {
        // 空字符串
        if str == ""
        {
            return false
        }
        
        // 将字符串转变为字符数组
        let characterArray = Array(str)
        
        // 首先尽可能多地扫描0 ~ 9的数位(有可能在起始处有+或者-)，也就是前面模式中表示数值整数的A部分
        var (numeric, index) = scanInteger(str: characterArray, startIndex: 0)
        
        
        // 如果遇到小数点.，则开始扫描表示数值小数部分的B部分
        if index < characterArray.count && characterArray[index] == "."
        {
            index += 1
            let result = scanUnsignedInteger(str: characterArray, startIndex: index)
            numeric = numeric || result.0// 是否有整数部分
            index = result.1
        }
        
        // 如果遇到e或者E则开始扫描表示数值指数的C部分
        // 12e index=2 count=3 如果不-1 则digits.contains(str[3])崩溃了
        if index < characterArray.count - 1 && (characterArray[index] == "e" || characterArray[index] == "E")
        {
            index += 1
            let result = scanInteger(str: characterArray, startIndex: index)
            numeric = numeric && result.0// 是否有整数部分
            index = result.1
        }
         
        return numeric && (index == str.count)
    }
    
    /**
     匹配数值字符串中整数部分（可能包含+和-符号）
     - Parameters:
        - str: 字符串
        - startIndex: 当前匹配索引
     - Returns:(是否有整数部分, 整数结束索引)
     */
    private func scanInteger(str: [Character], startIndex: Int) -> (Bool, Int)
    {
        // 移除正负符号
        var startIndex = startIndex
        if str[startIndex] == "+" || str[startIndex] == "-"
        {
            startIndex += 1
        }
        
        // 再调用无符号字符的匹配方法
        return scanUnsignedInteger(str: str, startIndex: startIndex)
    }
    
    /**
     匹配数值字符串中无符号整数部分, A[.[B]][e|EC] 即：其中的A（移除正负符号后）和B
     - Parameters:
        - str: 字符串
        - startIndex: 当前匹配索引
     - Returns: (是否有整数部分, 整数结束索引)
     */
    private func scanUnsignedInteger(str: [Character], startIndex: Int) -> (Bool, Int)
    {
        var index = startIndex
        while index < str.count && digits.contains(str[index])
        {
            index += 1
        }
        return (index > startIndex, index)
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
        XCTAssertEqual(solution.isNumeric(str: "100"), true)
        XCTAssertEqual(solution.isNumeric(str: "123.45e+6"), true)
        XCTAssertEqual(solution.isNumeric(str: "+500"), true)
        XCTAssertEqual(solution.isNumeric(str: "5e2"), true)
        XCTAssertEqual(solution.isNumeric(str: "3.1416"), true)
        XCTAssertEqual(solution.isNumeric(str: "600."), true)
        XCTAssertEqual(solution.isNumeric(str: "-.123"), true)
        XCTAssertEqual(solution.isNumeric(str: "-1E-16"), true)
        XCTAssertEqual(solution.isNumeric(str: "1.79769313486232E+308"), true)
        XCTAssertEqual(solution.isNumeric(str: "12e"), false)
        XCTAssertEqual(solution.isNumeric(str: "1a3.14"), false)
        XCTAssertEqual(solution.isNumeric(str: "1+23"), false)
        XCTAssertEqual(solution.isNumeric(str: "1.2.3"), false)
        XCTAssertEqual(solution.isNumeric(str: "+-5"), false)
        XCTAssertEqual(solution.isNumeric(str: "12e+5.4"), false)
        XCTAssertEqual(solution.isNumeric(str: "12e+5.4fg"), false)
        XCTAssertEqual(solution.isNumeric(str: "."), false)
        XCTAssertEqual(solution.isNumeric(str: ".e1"), false)
        XCTAssertEqual(solution.isNumeric(str: "+."), false)
        XCTAssertEqual(solution.isNumeric(str: ""), false)
    }
}

UnitTests.defaultTestSuite.run()


