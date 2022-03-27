import Foundation
import XCTest

// 二叉树节点
class BinaryTreeNode
{
    var leftNode: BinaryTreeNode?// 左节点，可能不存在
    var rightNode: BinaryTreeNode?// 右节点，可能不存在
    var value: Int// 当前节点的值
    
    init(_ value: Int, leftNode: BinaryTreeNode?, rightNode: BinaryTreeNode?)
    {
        self.leftNode = leftNode
        self.rightNode = rightNode
        self.value = value
    }
    
    // 前序遍历
    func preOrder() -> [Int]
    {
        var result = [Int]()
        preOrderCore(self, result: &result)
        return result
    }
    
    // 实现前序遍历的私有核心方法
    private func preOrderCore(_ node: BinaryTreeNode?, result: inout [Int])
    {
        guard let node = node else { return }
        
        // 使用递归方式实现前序遍历
        result.append(node.value)
        preOrderCore(node.leftNode, result: &result)
        preOrderCore(node.rightNode, result: &result)
    }
    
    // 中序遍历同理
    func inOrder() -> [Int]
    {
        var result = [Int]()
        inOrderCore(self, result: &result)
        return result
    }
    
    private func inOrderCore(_ node: BinaryTreeNode?, result: inout [Int])
    {
        guard let node = node else { return }
            
        inOrderCore(node.leftNode, result: &result)
        result.append(node.value)
        inOrderCore(node.rightNode, result: &result)
    }
}

class Solution
{
    
}

class UnitTests: XCTestCase
{
    var solution: Solution!
    
    override func setUp()
    {
        super.setUp()
        
        solution = Solution()
    }
    

}

UnitTests.defaultTestSuite.run()
