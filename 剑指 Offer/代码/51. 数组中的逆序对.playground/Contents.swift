import Foundation
import XCTest

class Solution
{
    /**
     求数组中的逆序对
     解法：利用归并排序算法，left 和 right 部分分别从尾到头进行合并，如果当前合并 left > right，则逆序对的数量记上 right 部分未合并项的数量
     - Parameters:
        - data: 输入的数组
     - Returns: (pairCount: 逆序对的个数 mergedArray: 合并后的数组)
     */
    func inversePairs<T: Comparable>(_ data: [T]) -> (pairCount: Int, mergedArray: [T])
    {
        // 递归结束条件：当子数组被拆分成长度为1的子数组时，长度为1的子数组开始返回（逆序对个数为0，合并后的数组为自身）
        guard data.count > 1 else { return (0, data) }
            
        // 把数组分解成两个长度相等的子数组
        let mid = data.count / 2
        
        // 开始递归：找到左、右子数组的（逆序对的个数，合并后的数组）
        // 由于我们已经统计了这两对子数组内部的逆序对，因此需要把这两对子数组排序，以免在以后的统计过程中再重复统计
        let leftResult = inversePairs(Array(data[0..<mid]))
        let rightResult = inversePairs(Array(data[mid...]))
        
        // 然后再统计出两个相邻子数组之间的逆序对的数目
        let mergedResult = inversePairsCore(leftArray: leftResult.mergedArray, rightArray: rightResult.mergedArray)
        
        // 返回最终的结果（左、右子数组内部的逆序对 + 这两个相邻子数组之间的逆序对的数目，归并排序结果）
        return (leftResult.pairCount + rightResult.pairCount + mergedResult.pairCount, mergedResult.mergedArray)
    }
    
    /**
     合并左右两个数组，并排序
     - Parameters:
        - leftArray: 左数组
        - rightArray: 右数组
     - Returns: pairCount:逆序对的个数 merged 合并后的数组
     */
    func inversePairsCore<T: Comparable>(leftArray: [T], rightArray: [T]) -> (pairCount: Int, mergedArray: [T])
    {
        // 先用两个指针分别指向两个子数组的末尾，并每次比较两个指针指向的数字
        var leftEndIndex = leftArray.endIndex - 1
        var rightEndIndex = rightArray.endIndex - 1
        
        // 每次比较的时候，我们都把较大的数字从后往前复制到一个辅助数组，确保辅助数组中的数字是递增排序的
        var orderArray = [T]()
        
        // 两个相邻子数组之间的逆序对的数目
        var inversePairCount = 0
        
        // 预留足够的空间去存储指定数目的元素
        if orderArray.capacity < leftArray.count + rightArray.count
        {
            orderArray.reserveCapacity(leftArray.count + rightArray.count)
        }
        
        while true
        {
            // 循环结束条件：leftEndIndex或者rightEndIndex减少为0的时候
            guard leftEndIndex >= 0 else {
                // 左边子数组完成了合并，右边子数组还有剩余元素
                for index in stride(from: rightEndIndex, through: 0, by: -1)
                {
                    // 由于右边子数组本身是有序的，所以只需要将剩余元素全部直接插入到辅助数组即可
                    orderArray.insert(rightArray[index], at: 0)
                }
                
                break
            }
            
            guard rightEndIndex >= 0 else {
                // 右边子数组完成了合并，左边子数组还有剩余元素
                for index in stride(from: leftEndIndex, through: 0, by: -1)
                {
                    // 由于左边子数组本身是有序的，所以只需要将剩余元素全部直接插入到辅助数组即可
                    orderArray.insert(leftArray[index], at: 0)
                }
                
                break
            }
            
            // 如果第一个子数组中的数字大于第二个子数组中的数字，则构成逆序对
            if leftArray[leftEndIndex] > rightArray[rightEndIndex]
            {
                // 逆序对的数目等于第二个子数组中剩余数字的个数（index从0开始，所以计算数量的时候需要+1）
                inversePairCount = inversePairCount + rightEndIndex + 1
                
                // 把较大的数字从后往前复制到辅助数组，确保辅助数组中的数字是递增排序的
                orderArray.insert(leftArray[leftEndIndex], at: 0)
                
                // 把对应的指针向前移动一位，接下来进行下一轮比较
                leftEndIndex -= 1
            }
            // 如果第一个数组中的数字小于或等于第二个数组中的数字，则不构成逆序对
            else
            {
                // 把较大的数字从后往前复制到辅助数组，确保辅助数组中的数字是递增排序的
                orderArray.insert(rightArray[rightEndIndex], at: 0)
                
                // 把对应的指针向前移动一位，接下来进行下一轮比较
                rightEndIndex -= 1
            }
        }
        
        // 返回最终的结果
        return (inversePairCount, orderArray)
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
        let data = [1,2,3,4,7,6,5]
        XCTAssertEqual(3, solution.inversePairs(data).pairCount)
    }
    
    func testCase2()
    {
        let data = [6,5,4,3,2,1]
        XCTAssertEqual(15, solution.inversePairs(data).pairCount)
    }
    
    func testCase3()
    {
        let data = [1,2,3,4,5,6]
        XCTAssertEqual(0, solution.inversePairs(data).pairCount)
    }
    
    func testCase4()
    {
        let data = [1]
        XCTAssertEqual(0, solution.inversePairs(data).pairCount)
    }
    
    func testCase5()
    {
        let data = [1,2]
        XCTAssertEqual(0, solution.inversePairs(data).pairCount)
    }
    
    func testCase6()
    {
        let data = [2,1]
        XCTAssertEqual(1, solution.inversePairs(data).pairCount)
    }
    
    func testCase7()
    {
        let data = [1,2,1,2,1]
        XCTAssertEqual(3, solution.inversePairs(data).pairCount)
    }
}

UnitTests.defaultTestSuite.run()
