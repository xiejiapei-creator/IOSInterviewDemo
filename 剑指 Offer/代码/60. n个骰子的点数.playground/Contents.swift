import Foundation
import XCTest

class Solution
{
    // 骰子里最大的值
    let diceMaxValue: Int = 6
    
    /**
     n个骰子的点数
     解法：递归计算出所有可能和的出现次数，最后与总次数相除算出概率
     - Paramters:
        - number: 骰子的个数
     - Return: 所有骰子朝上一面的点数之和为s，s的所有可能的值出现的概率
     */
    func printProbability_Solution1(_ number: Int) -> [Int: Double]
    {
        // 存储s的所有可能的值出现的概率
        var result = [Int: Double]()
        guard number > 0 else { return result }
            
        // 计算s可能出现的最大值
        let maxSum = number * diceMaxValue
        
        // number个骰子的和是不会出现 (1到[num-1]) 这几个数字的，所以可能出现的和总数是 maxSum - number + 1
        // 比如number为2即2个骰子，则不会出现1，maxSum为12，maxSum - number + 1为11，即和只会出现11种可能性
        var sumProbabilitieCounts = Array(repeating: 0, count: maxSum - number + 1)
        
        // 统计每个s值出现的次数
        sumProbabilitieCounts = probability(number, sumProbabilitieCounts)
        
        // 根据排列组合的知识，我们还知道n个骰子的所有点数的排列数为6ᴺ
        // 这里涉及到指数运算，由于n可能比较大超出了int型表示的范围，故需转换数据类型
        let total = (pow(Decimal(diceMaxValue), number) as NSDecimalNumber).doubleValue
        
        // 遍历每一种可能性
        for (index, sumProbabilitieCount) in sumProbabilitieCounts.enumerated()
        {
            // result是个字典，key是s的可能的值
            // 需要先统计出每个s值出现的次数，然后把每个s值出现的次数除以6ᴺ，就能求出每个点数出现的概率
            result[index + number] = Double(sumProbabilitieCount) / total
        }
        
        return result
    }
    
    // 统计每个s值出现的次数
    private func probability(_ number: Int, _ probabilities: [Int]) -> [Int]
    {
        var probabilities = probabilities
        
        // 骰子点数，这里是1到6
        for index in 1...diceMaxValue
        {
            probabilities = probabilityCore(original: number, current: number, sum: index, probabilities: probabilities)
        }
        return probabilities;
    }
    
    // 来自书上统计每个s值出现的次数的算法
    private func probabilityCore(original: Int, current: Int, sum: Int, probabilities: [Int] ) -> [Int]
    {
        var probabilities = probabilities

        // 第一堆只有一个，另一堆有n-1个
        if current == 1
        {
            // 单独的那一个有可能出现1~6的点数
            probabilities[sum - original] += 1
        }
        // 接下来把剩下的n-1个骰子仍然分成两堆：第一堆只有一个，第二堆有n-2个
        else
        {
            // 骰子点数，这里是1到6
            for index in 1...diceMaxValue
            {
                // 我们把上一轮那个单独骰子的点数和这一轮单独骰子的点数相加，再和剩下的n-2个骰子来计算点数和
                // 在循环体中current和sum值保持不变，是传入进来的2和1，只是index一个变量在每次+1，导致递归传入的current始终为1，sum值从1增加到12
                probabilities = probabilityCore(original: original, current: current - 1, sum: sum + index, probabilities: probabilities)
            }
        }

        return probabilities
    }
    
    /**
     n个骰子的点数
     解法：利用两个数组
     - Paramters:
        - number: 骰子的个数
     - Return: 所有骰子朝上一面的点数之和为s，s的所有可能的值出现的概率
     */
    func printProbability_Solution2(_ number: Int) -> [Int: Double]
    {
        var result = [Int: Double]()
        guard number > 0 else
        {
            return result
        }
        
        var probabilities = [[Int]]()
        probabilities.append(Array.init(repeating: 0, count: diceMaxValue * number + 1 ))
        probabilities.append(Array.init(repeating: 0, count: diceMaxValue * number + 1 ))
        
        var flag = 0
        for index in 1...diceMaxValue
        {
            probabilities[flag][index] = 1
        }
        
        for r in 2...number
        {
            // 将另一个数组的小于r的元素都设置为 0 （因为r个骰子的和不会比r小）
            for index in 0..<r
            {
                probabilities[1-flag][index] = 0
            }
            
            // 开始处理 r 到 最大值（DiceMaxvalue*r）之间的的情况
            for index in r...diceMaxValue * r
            {
                probabilities[1-flag][index] = 0
                for j in 1...min(index, diceMaxValue)
                {
                    probabilities[1-flag][index] += probabilities[flag][index - j];
                }
            }
            flag = 1 - flag
        }
        let total = (pow(Decimal(diceMaxValue), number) as NSDecimalNumber).doubleValue
        for (index, probability) in probabilities[flag].enumerated()
        {
            if index >= number
            {
                result[index] = Double(probability) / total
            }
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
    
    func testCase1()
    {
        let result1 = solution.printProbability_Solution1(2)
        let result2 = solution.PrintProbability_Solution2(2)
    }
    

}

UnitTests.defaultTestSuite.run()
 
