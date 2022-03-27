import Foundation
import XCTest

class Solution
{
    /**
     返回数组中只出现一次的两个数字(其他数字都出现了两次)
     - Parameters:
        - array: 数组
     - Returns: 两个数字
     */
    func findNumsAppearOnce(_ array: [Int]) -> (number1: Int?, number2: Int?)
    {
        guard array.count >= 2 else { return (nil, nil) }
        
        // 从头到尾依次异或数组中的每个数字，那么最终得到的结果就是两个只出现一次的数字的异或结果，因为其他数字都出现了两次，在异或中全部抵消了
        let xorReslt = array.reduce(0){
            return $0 ^ $1
        }

        // 查找从右边数起第一个是1的位的位置
        let firstBitIndex = findFirstBitIs1(xorReslt)

        // 我们把原数组分成了两个子数组（分组的标准是数字中的某一位是1还是0），每个子数组都包含一个只出现一次的数字， 而其他数字都出现了两次
        var number1 = 0, number2 = 0
        for number in array
        {
            if isBit1(number, at: firstBitIndex)
            {
                number1 ^= number
            }
            else
            {
                number2 ^= number
            }
        }
        
        // 最终的结果刚好是那个只出现一次的数字，因为那些成对出现两次的数字全部在异或中抵消了
        return (min(number1, number2), max(number1, number2))
    }
    
    // 查找从右边数起第一个是1的位的位置
    private func findFirstBitIs1(_ number: Int) -> Int
    {
        // 记录第一个是1的位的位置
        var index = 0
        var number = number
        
        // (00010 & 00001 = 00000) && (0 < 5)
        while number & 1 == 0 && index < number.bitWidth
        {
            // 00001 = 00010 >> 1
            number = number >> 1
            // 下一个位置 1
            index += 1
        }
        
        // 返回第一个是1的位的位置（在00010中该位置为1）
        return index
    }
    
    // 判断数字的第index位是不是1
    private func isBit1(_ number: Int, at index:Int) ->  Bool
    {
        // 将二进制数字右移index位，将第index位的数字放到末尾
        let number = number >> index
        
        // 再将移动后的二进制数据和1做与运算，等于1说明第index位的数字为1
        return number & 1 == 1
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
        let number = [2,4,3,6,3,2,5,5]
        XCTAssertEqual(4, solution.findNumsAppearOnce(number).number1)
        XCTAssertEqual(6, solution.findNumsAppearOnce(number).number2)
    }
    
    func testCase2()
    {
        let number = [4,6]
        XCTAssertEqual(4, solution.findNumsAppearOnce(number).number1)
        XCTAssertEqual(6, solution.findNumsAppearOnce(number).number2)
    }

    func testCase3()
    {
        let number = [4,6,1,1,1,1]
        XCTAssertEqual(4, solution.findNumsAppearOnce(number).number1)
        XCTAssertEqual(6, solution.findNumsAppearOnce(number).number2)
    }
}

UnitTests.defaultTestSuite.run()

