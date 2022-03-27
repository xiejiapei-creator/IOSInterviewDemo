import Foundation
import XCTest

class Solution
{
    /**
     判断输入的数组是否是某二叉搜索树的后序遍历序列
     - Parameters:
        - sequence: 后序遍历序列
     - Returns: 判断结果
     */
    func verifySquenceOfBST(_ squence: [Int]) -> Bool
    {
        guard squence.count > 0 else {
            return false
        }
        
        // 后序遍历的最后一个数字是根节点
        let rootValue = squence.last!
        
        // 二叉搜索树左子树的节点小于根节点
        var index = 0// 记录左右子树在序列中的分界点
        var leftTreeValue = [Int]()
        for i in 0..<squence.count - 1// -1是因为不能将末尾的根节点加入到左子树中
        {
            if squence[i] > rootValue
            {
                break
            }
            index += 1
            leftTreeValue.append(squence[i])
        }
        
        // 二叉搜索树右子树的节点大于根节点
        var rightTreeValue = [Int]()
        for i in index ..< squence.count - 1// -1是因为不能将末尾的根节点加入到右子树中
        {
            // 一旦在右子树中出现节点值比根节点值小的则判断结果为false
            if squence[i] < rootValue
            {
                return false
            }
            rightTreeValue.append(squence[i])
        }

        // 递归判断左子树是不是二叉搜索树
        var leftResult = true
        if leftTreeValue.count > 1// 只剩1个的时候就表示到达了叶子节点了
        {
            leftResult = verifySquenceOfBST(leftTreeValue)
        }
        
        // 递归判断右子树是不是二叉搜索树
        var rightResult = true
        if rightTreeValue.count > 1
        {
            rightResult = verifySquenceOfBST(rightTreeValue)
        }
        
        return leftResult && rightResult
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
      XCTAssertEqual(solution.verifySquenceOfBST([4,8,6,12,16,14,10]), true)
    }
    
    func testCase2()
    {
        XCTAssertEqual(solution.verifySquenceOfBST([4,6,7,5]), true)
    }

    func testCase3()
    {
        XCTAssertEqual(solution.verifySquenceOfBST([1,2,3,4,5]), true)
    }

    func testCase4()
    {
        XCTAssertEqual(solution.verifySquenceOfBST([5,4,3,2,1]), true)
    }

    func testCase5()
    {
        XCTAssertEqual(solution.verifySquenceOfBST([5]), true)
    }

    func testCase6()
    {
        XCTAssertEqual(solution.verifySquenceOfBST([7,4,6,5]), false)
    }

    func testCase7()
    {
        XCTAssertEqual(solution.verifySquenceOfBST([4,6,12,8,16,14,10]), false)
    }
}

UnitTests.defaultTestSuite.run()

