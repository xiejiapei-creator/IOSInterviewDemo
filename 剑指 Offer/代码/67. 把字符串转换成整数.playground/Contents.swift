import Foundation
import XCTest

class Solution
{
    /*
     将字符串转换为整形
     - Parameters:
        - string: 需要转换成数字的字符串
     - Returns: 转换之后的整数
     */
    func stringToInt(_ string: String) -> Int?
    {
        // 字符串为空
        if string == ""
        {
            return nil
        }
        
        // 字符串只包含+-号不包含数字
        if string == "+" || string == "-"
        {
            return 0
        }
        
        // 将字符串转变为字符数组
        var charactersArray = Array(string)
        
        // 1.去除数字的符号位
        
        // 用来判断数字是否为负数
        var minus = false
        // 去除字符串的第一个字符（-号）
        if charactersArray.first! == "-"
        {
            minus = true
            charactersArray.removeFirst()
        }
        // 去除字符串的第一个字符（+号）
        if charactersArray.first! == "+"
        {
            charactersArray.removeFirst()
        }
        
        // 2.将剩下的无符号数字从字符转变为数字
        
        var resultNumber: UInt = 0
        // 遍历字符串中的每个字符
        for character in charactersArray
        {
            // 将字符转换为整数，再将整数转变为无符号整数，有点绕但系统不支持UInt(Character)直转
            if let characterNumber = Int(String(character))
            {
                // 因为是十进制所以还需要 * 10 保证十位百位等
                // 如"+21" -> "2""1" -> 0*10 + 2 -> 2*10 + 1 ->21
                resultNumber = resultNumber * 10 + UInt(characterNumber)
                
                // 3.确保不会出现数据上溢和下溢
                
                // Int.max =  9223372036854775807
                if resultNumber > UInt(Int64.max) && !minus
                {
                    return nil
                }
                
                // Int.min = -9223372036854775808
                if resultNumber > UInt(Int64.max) + 1 && minus
                {
                    return nil
                }
            }
            // 特殊字符直接打回去
            else
            {
                return nil
            }
        }
        
        
        // 处理负数的上限：Not enough bits to represent the passed value
        if resultNumber > Int.max && minus
        {
            return Int.min
        }
        
        return Int(resultNumber) * (minus ? -1 : 1)
    }
}

class UnitTests: XCTestCase
{
    let solution = Solution()
    override func setUp()
    {
        super.setUp()
    }
    
    func testCase1()
    {
        XCTAssertEqual(nil, solution.stringToInt(""))
        XCTAssertEqual(123, solution.stringToInt("123"))
        XCTAssertEqual(123, solution.stringToInt("+123"))
        XCTAssertEqual(-123, solution.stringToInt("-123"))
        XCTAssertEqual(nil, solution.stringToInt("1a23"))
        XCTAssertEqual(0, solution.stringToInt("+0"))
        XCTAssertEqual(0, solution.stringToInt("-0"))
        XCTAssertEqual(0, solution.stringToInt("+"))
        XCTAssertEqual(0, solution.stringToInt("-"))
    }
    
    func testCase2()
    {
        // Int.max =  9223372036854775807
        // Int.min = -9223372036854775808
        XCTAssertEqual(9223372036854775807, solution.stringToInt("+9223372036854775807"))
        XCTAssertEqual(nil, solution.stringToInt("+9223372036854775808"))
        XCTAssertEqual(-9223372036854775808, solution.stringToInt("-9223372036854775808"))
        XCTAssertEqual(nil, solution.stringToInt("-9223372036854775809"))
    }
}

UnitTests.defaultTestSuite.run()

