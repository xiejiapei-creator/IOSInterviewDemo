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
    /**
     根据前序序列和中序序列构建二叉树
     - Parameters:
        - preOrder: 前序序列数组
        - inOrder: 中序序列数组
     - Returns: BinaryTreeNode 构建好的二叉树根节点
     */
    func ConstructTree(preOrder: [Int], inOrder: [Int]) -> BinaryTreeNode?
    {
        if (preOrder.count == 0 || inOrder.count == 0 || preOrder.count != inOrder.count)
        {
            return nil
        }
        
        return ConstructTreeCore(preOrder: preOrder, preOrderStartIndex: 0, preOrderEndIndex: preOrder.count - 1, inOrder: inOrder, inOrderStartIndex: 0, inOrderEndIndex: inOrder.count - 1)
    }
    
    // 根据前序序列和中序序列构建二叉树的私有核心方法
    private func ConstructTreeCore(preOrder: [Int], preOrderStartIndex: Int, preOrderEndIndex: Int, inOrder: [Int], inOrderStartIndex: Int, inOrderEndIndex: Int) -> BinaryTreeNode?
    {
        // 前序序列的第一个数字就是根节点
        let rootNode = BinaryTreeNode(preOrder[preOrderStartIndex], leftNode: nil, rightNode: nil)
        
        // 在中序序列中查找根节点的位置
        var rootNodeIndexInOrder = -1
        for index in inOrderStartIndex...inOrderEndIndex
        {
            if inOrder[index] == preOrder[preOrderStartIndex]
            {
                rootNodeIndexInOrder = index
                break
            }
        }
        
        // 未能在在中序序列中查找根节点的位置说明两个序列不匹配则直接返回
        if rootNodeIndexInOrder == -1
        {
            return nil
        }
        
        // 左子树的节点个数
        let leftTreeElementCount = rootNodeIndexInOrder - inOrderStartIndex
        
        
        print("根节点的值：\(rootNode.value)，根节点的位置：\(rootNodeIndexInOrder)，左子树的节点个数：\(leftTreeElementCount)")
        
        // 在前序序列中递归构建左子树
        if preOrderStartIndex + 1 <= preOrderStartIndex + leftTreeElementCount// 递归结束条件
        {
            rootNode.leftNode = ConstructTreeCore(preOrder: preOrder, preOrderStartIndex: preOrderStartIndex + 1, preOrderEndIndex: preOrderStartIndex + leftTreeElementCount, inOrder: inOrder, inOrderStartIndex: inOrderStartIndex, inOrderEndIndex: rootNodeIndexInOrder - 1)
            
            if let leftNodeVale = rootNode.leftNode?.value
            {
                print("左节点的值：\(leftNodeVale)")
            }
        }
        
        // 在前序序列中递归构建右子树
        if preOrderStartIndex + leftTreeElementCount + 1 <= preOrderEndIndex
        {
            rootNode.rightNode = ConstructTreeCore(preOrder: preOrder, preOrderStartIndex: preOrderStartIndex + leftTreeElementCount + 1, preOrderEndIndex: preOrderEndIndex, inOrder: inOrder, inOrderStartIndex: rootNodeIndexInOrder + 1, inOrderEndIndex: inOrderEndIndex)
            
            if let rightNodeVale = rootNode.rightNode?.value
            {
                print("右节点的值：\(rightNodeVale)")
            }
        }
        
        
        return rootNode
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
    
    // 普通二叉树
    func testCase1()
    {
        let preOrder = [1, 2, 4, 7, 3, 5, 6, 8]
        let inOrder = [4, 7, 2, 1, 5, 3, 8, 6]
        let result = solution.ConstructTree(preOrder: preOrder, inOrder: inOrder)
        
        XCTAssertTrue(result?.preOrder() == preOrder)
        XCTAssertTrue(result?.inOrder() == inOrder)
    }
    
    // 所有结点都没有右子结点
    func testCase2()
    {
        let preOrder = [1, 2, 3, 4, 5]
        let inOrder = [5, 4, 3, 2, 1]
        let result = solution.ConstructTree(preOrder: preOrder, inOrder: inOrder)
        
        XCTAssertTrue(result?.preOrder() == preOrder)
        XCTAssertTrue(result?.inOrder() == inOrder)
    }
    
    // 所有结点都没有左子结点
    func testCase3()
    {
        let preOrder = [1, 2, 3, 4, 5]
        let inOrder = [1, 2, 3, 4, 5]
        let result = solution.ConstructTree(preOrder: preOrder, inOrder: inOrder)
        
        XCTAssertTrue(result?.preOrder() == preOrder)
        XCTAssertTrue(result?.inOrder() == inOrder)
    }
    
    // 树中只有一个结点
    func testCase4()
    {
        let preOrder = [1]
        let inOrder = [1]
        let result = solution.ConstructTree(preOrder: preOrder, inOrder: inOrder)
        
        XCTAssertTrue(result?.preOrder() == preOrder)
        XCTAssertTrue(result?.inOrder() == inOrder)
    }
    
    // 完全二叉树
    func testCase5()
    {
        let preOrder = [1, 2, 4, 5, 3, 6, 7]
        let inOrder = [4, 2, 5, 1, 6, 3, 7]
        let result = solution.ConstructTree(preOrder: preOrder, inOrder: inOrder)
        
        XCTAssertTrue(result?.preOrder() == preOrder)
        XCTAssertTrue(result?.inOrder() == inOrder)
    }
    
    // 输入的两个序列不匹配
    func testCase6()
    {
        let preOrder = [1, 2, 4, 5, 3, 6, 7]
        let inOrder = [4, 2, 8, 1, 6, 3, 7]
        let result = solution.ConstructTree(preOrder: preOrder, inOrder: inOrder)
        
        XCTAssertFalse(result?.preOrder() == preOrder)
        XCTAssertFalse(result?.inOrder() == inOrder)
    }
}

UnitTests.defaultTestSuite.run()
