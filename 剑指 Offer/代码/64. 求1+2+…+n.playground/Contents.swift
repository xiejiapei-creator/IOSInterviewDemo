import Foundation
import XCTest

// 解法一：利用构造函数求解
class Solution1// 我们先定义一个类型
{
    // 静态变量，用来存储累加和
    private static var sum = 0
    
    // 静态变量，作为每次增加的数字
    private static var n = 1
    
    // 这个类型的构造函数将确定会被调用n次
    init()
    {
        // 我们可以将与累加相关的代码放到构造函数里
        Solution1.sum += Solution1.n
        Solution1.n += 1
    }
    
    // 重置静态变量以便下次计算
    static func resetStaticVar()
    {
        sum = 0
        n = 1
    }
    
    // 返回累加和
    static func getSum(_ n: Int) -> Int
    {
        // 创建n个该类型的实例
        // 通过concurrent和sync保证累加逐次进行，不会发生线程错乱
        let queue = DispatchQueue(label: "accumulate")
        DispatchQueue.concurrentPerform(iterations: n)
        { i in
            queue.sync
            {
                _ = Solution1()
            }
        }
        
        // 获取累加静态变量的值
        let result = sum
        
        // 重置静态变量
        resetStaticVar()
        
        // 返回累加和
        return result
    }
}

// 解法二：利用两个函数实现递归
class Solution2
{
    // n是为sumFunction函数传入的参数，返回的就是累加和
    typealias sumFunction = (Int) -> Int
    
    // functions包含了两个函数，一个函数充当递归函数的角色，另一个函数处理终止递归的情况，此时为[]
    var functions = Array<sumFunction>()
    
    init()
    {
        // 此时从[]转变为[(Function)]，此处加入的函数处理终止递归
        functions.append({ (i) in return 0 })
        
        // 此时从[]转变为[(Function), (Function)]，，此处加入的函数充当递归函数
        functions.append({ [unowned self](i) in
            
            // 如果对n连续做两次反运算，即!!n，那么非零的n转换为true，0转换为false，所以此处index只有1和0两个值，0来自于终止递归函数的返回值
            let index = Int(truncating: Bool(truncating: i as NSNumber) as NSNumber)
            
            // i就是传入的n，递归函数调用的过程：f(i-1)+i
            return self.functions[index](i - 1) + i
        })
    }
    
    // 返回累加和
    func getSum(_ n:Int) -> Int
    {
        
        // 值为true(1)的时候调用第一个函数，值为false(0)的时候调用第二个函数
        return functions[1](n)
    }
}

class UnitTests: XCTestCase
{
    
    override func setUp()
    {
        super.setUp()
    }
    
    func testCase1()
    {
        XCTAssertEqual(1, Solution1.getSum(1))
        XCTAssertEqual(15, Solution1.getSum(5))
        XCTAssertEqual(55, Solution1.getSum(10))
        XCTAssertEqual(0, Solution1.getSum(0))
    }

    func testCase2()
    {
        let solution2 = Solution2()
        
        XCTAssertEqual(1, solution2.getSum(1))
        XCTAssertEqual(15, solution2.getSum(5))
        XCTAssertEqual(55, solution2.getSum(10))
        XCTAssertEqual(0, solution2.getSum(0))
    }
}

UnitTests.defaultTestSuite.run()

