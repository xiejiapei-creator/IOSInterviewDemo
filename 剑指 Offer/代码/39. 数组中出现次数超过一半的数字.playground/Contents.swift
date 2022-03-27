import Foundation
import XCTest

class Solution
{
    /**
     找出数组中出现次数超过一半的数字
     解法：将数组排序（不一定要完全排序，利用快排原理，只要找到中位数即可），如果某个数字的次数超过数组长度一半，那么该数字必然是数组中间的那个数字（中位数不是中间数字）
     - Parameters:
        - numbers: 数组
     - Returns: 出现次数超过数组长度一半的数字
     */
    func moreThanHalfNumber_Solution1(_ numbers: [Int]) -> Int?
    {
        // 数组为空
        if numbers.count == 0
        {
            return nil
        }
        
        var numbers = numbers
        var startIndex = 0// 开始位置
        var endIndex = numbers.count - 1// 结束位置
        let middleIndex = numbers.count / 2// 中间位置
        var partitionIndex = partition(&numbers, start: startIndex, end: endIndex)// 分区位置
        
        while partitionIndex != middleIndex
        {
            // 如果它的下标大于n/2，那么中位数应该位于它的左边，我们可以接着在它的左边部分的数组中查找
            if partitionIndex > middleIndex
            {
                endIndex = partitionIndex - 1
            }
            // 如果它的下标小于n/2，那么中位数应该位于它的右边，我们可以接着在它的右边部分的数组中查找
            else
            {
                startIndex = partitionIndex + 1
            }
            partitionIndex = partition(&numbers, start: startIndex, end: endIndex)
        }
        
        
        // 获取中位数：中位数不是中间数字
        let middleNumber = numbers[middleIndex]
        
        // 数组中是否出现一半以上的指定中位数
        return checkNumberMoreThanHalf(numbers, number: middleNumber) ? middleNumber : nil
    }
    
    /**
     验证数组中是否出现一半以上的指定数字
     - Parameters:
        - array: 数组
        - number: 指定数字
     - Returns: 验证结果
     */
    func checkNumberMoreThanHalf(_ array: [Int], number: Int) -> Bool
    {
        return array.filter{ $0 == number }.count * 2 > array.count ? true : false
    }
    
    /**
     将数组在指定范围内[start，end]分区，使得左边部分数字比右边部分的小
     - Parameters:
        - nums: 数组
        - start: 分区开始索引
        - end: 分区结束索引
     - Returns: index：当前分区的分界索引
     */
    func partition(_ numbers: inout [Int], start: Int, end: Int) -> Int
    {
        // 数组为空或者分区开始索引大于分区结束索引
        if numbers.count == 0 || start > end
        {
            return start
        }
        
        let pivot = numbers[start]// 以第一个数字作为分区中心点
        var startIndex = start + 1// 开始位置
        var endIndex = end// 结束位置
        
        while true
        {
            // 左边部分数字比中心点小
            while numbers[startIndex] <= pivot && startIndex < end
            {
                startIndex += 1
            }
            
            // 右边部分数字比中心点大
            while numbers[endIndex] > pivot
            {
                endIndex -= 1
            }
            
            // 开始位置和结束位置还未碰头就将左边比中心点大的数字和右边比中心点小的数字进行交换
            if startIndex < endIndex
            {
                (numbers[startIndex], numbers[endIndex]) = (numbers[endIndex], numbers[startIndex])
            }
            // 开始位置和结束位置已经碰头表示分区完成
            else
            {
                // 将中心点交换到分区位置
                (numbers[start], numbers[endIndex]) = (numbers[endIndex], numbers[start])
                
                // 返回分区位置
                return endIndex
            }
        }
    }
    
    /**
     找出数组中出现次数超过一半的数字
     解法：我们要找的数字出现的次数其他数字次数的和都多，所以要找的数字肯定是最后把次数设为1的数字
     - Parameters:
        - numbers: 数组
     - Returns: 出现次数超过数组长度一半的数字
     */
    func moreThanHalfNum_Solution2(_ numbers: [Int]) -> Int?
    {
        // 数组为空
        if numbers.count == 0
        {
            return nil
        }
        
        // 保存数组第一个数字result和次数times
        var result = numbers[0]
        var times = 1
        
        // 从index=1开始遍历数组，如果数字与result相同，times+1，否则times-1
        for index in 1 ..< numbers.count
        {
            // 如果times=0，result保存下一个遍历数字，times重置为1
            if times == 0
            {
                result = numbers[index]
                times = 1
            }
            
            if numbers[index] == result
            {
                times += 1
            }
            else
            {
                times -= 1
            }
        }
        
        // 数组中是否出现一半以上的指定数字
        return checkNumberMoreThanHalf(numbers, number: result) ? result : nil
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
    
    // 存在超过一半的数字
    func testCase1()
    {
        let nums = [1,2,3,2,2,2,5,4,2]
        XCTAssertEqual(2, solution.moreThanHalfNumber_Solution1(nums))
        XCTAssertEqual(2, solution.moreThanHalfNum_Solution2(nums))
    }
    
    // 不存在超过一半的数字
    func testCase2()
    {
        let nums = [1,2,3,2,4,2,5,2,3]
        XCTAssertEqual(nil, solution.moreThanHalfNumber_Solution1(nums))
        XCTAssertEqual(nil, solution.moreThanHalfNum_Solution2(nums))
    }

    // 存在超过一半的数字(该数字全部出现在数组前半部分)
    func testCase3()
    {
        let nums = [2,2,2,2,2,1,3,4,5]
        XCTAssertEqual(2, solution.moreThanHalfNumber_Solution1(nums))
        XCTAssertEqual(2, solution.moreThanHalfNum_Solution2(nums))
    }

    // 存在超过一半的数字(该数字全部出现在数组后半部分)
    func testCase4()
    {
        let nums = [1,3,4,5,2,2,2,2,2]
        XCTAssertEqual(2, solution.moreThanHalfNumber_Solution1(nums))
        XCTAssertEqual(2, solution.moreThanHalfNum_Solution2(nums))
    }
}

UnitTests.defaultTestSuite.run()

