import Foundation
import XCTest

class BinaryTreeNode: Equatable
{
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var value: Int
    
    init(value: Int, left: BinaryTreeNode?, right: BinaryTreeNode?)
    {
        self.value = value
        self.left = left
        self.right = right
    }
    
    static func ==(left: BinaryTreeNode, right: BinaryTreeNode) -> Bool
    {
        return left.value == right.value
    }
}

class Solution
{
    /**
     判断是否是平衡二叉树
     解法：判断各个节点的左右子树的深度相差是否超过1
     - Parameters:
        - root: 二叉树根节点
     - Returns: 判断结果
     */
    func isBalancedTree_Solution1(_ rootNode: BinaryTreeNode?) -> Bool
    {
        // 没有节点，树为空
        guard rootNode != nil else { return true }
             
        // 获取左右子树的深度
        let leftTreeDepth = treeDepth(rootNode!.left)
        let rightTreeDepth = treeDepth(rootNode!.right)
        
        // 判断各个节点的左右子树的深度相差是否超过1，大于1则非平衡二叉树
        if abs(rightTreeDepth - leftTreeDepth) > 1
        {
            return false
        }
        
        // 当最后遍历到树的根节点的时候，也就判断了整棵二叉树是不是平衡二叉树
        return isBalancedTree_Solution1(rootNode!.left) && isBalancedTree_Solution1(rootNode!.right)
    }
    
    // 求树的深度
    private func treeDepth(_ rootNode: BinaryTreeNode?) -> Int
    {
        guard rootNode != nil else { return 0 }
        
        let leftTreeDepth = treeDepth(rootNode?.left)
        let rightTreeDepth = treeDepth(rootNode?.right)

        return leftTreeDepth > rightTreeDepth ? leftTreeDepth + 1 : rightTreeDepth + 1
    }
    
    /**
     判断是否是平衡二叉树
     解法：利用后序遍历，重复利用之前的节点深度，避免重复遍历
     - Parameters:
        - root: 二叉树根节点
     - Returns: 判断结果
     */
    func isBalancedTree_Solution2(_ rootNode: BinaryTreeNode?) -> Bool
    {
        return isBalancedTreeCore(rootNode).balanced
    }
    
    // 返回二叉树的平衡状态和深度
    private func isBalancedTreeCore(_ rootNode: BinaryTreeNode?) -> (balanced: Bool, depth: Int)
    {
        // 没有节点，树为空
        guard rootNode != nil else { return (true, 0) }
        
        // 在遍历某节点的左、右子节点之后，我们可以根据它的左、右子节点的深度判断它是不是平衡的，并得到当前节点的深度
        let leftTreeResult = isBalancedTreeCore(rootNode!.left)
        let rightTreeResult = isBalancedTreeCore(rootNode!.right)
        
        // 获取左右子树的最大深度
        let maxDepth = max(leftTreeResult.depth, rightTreeResult.depth)
        
        // 左右子树均为平衡二叉树
        if leftTreeResult.balanced && rightTreeResult.balanced
        {
            // 深度小于1，说明整棵二叉树是平衡二叉树，那么返回结果
            if abs(rightTreeResult.depth - leftTreeResult.depth) <= 1
            {
                // 因为还要算上根节点，所以还要+1
                return (true, maxDepth + 1)
            }
        }
        
        // 返回非平衡二叉树的结果
        return (false, maxDepth + 1)
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
    
    // 完全二叉树
    func testCase1()
    {
        let node7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: node6, right: node7)
        let node2 = BinaryTreeNode(value: 2, left: node4, right: node5)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: node3)
        
        XCTAssertEqual(true, solution.isBalancedTree_Solution1(node1))
        XCTAssertEqual(true, solution.isBalancedTree_Solution2(node1))
    }
    
    // 不是完全二叉树，但是平衡二叉树
    func testCase2()
    {
        let node7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node5 = BinaryTreeNode(value: 5, left: node7, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: node6)
        let node2 = BinaryTreeNode(value: 2, left: node4, right: node5)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: node3)
        
        XCTAssertEqual(true, solution.isBalancedTree_Solution1(node1))
        XCTAssertEqual(true, solution.isBalancedTree_Solution2(node1))
    }
    
    // 不是平衡二叉树
    func testCase3()
    {
        let node6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node5 = BinaryTreeNode(value: 5, left: node6, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node2 = BinaryTreeNode(value: 2, left: node4, right: node5)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: node3)
        
        XCTAssertEqual(false, solution.isBalancedTree_Solution1(node1))
        XCTAssertEqual(false, solution.isBalancedTree_Solution2(node1))
    }
    
    // 二叉树中所有节点都没有左/右子树
    func testCase4()
    {
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: node5, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: node4, right: nil)
        let node2 = BinaryTreeNode(value: 2, left: node3, right: nil)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: nil)
        XCTAssertEqual(false, solution.isBalancedTree_Solution1(node1))
        XCTAssertEqual(false, solution.isBalancedTree_Solution2(node1))
    }
    
    func testCase5()
    {
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: node5)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: node4)
        let node2 = BinaryTreeNode(value: 2, left: nil, right: node3)
        let node1 = BinaryTreeNode(value: 1, left: nil, right: node2)
        XCTAssertEqual(false, solution.isBalancedTree_Solution1(node1))
        XCTAssertEqual(false, solution.isBalancedTree_Solution2(node1))
    }
    
    // 只有1个节点
    func testCase6()
    {
        let node1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        XCTAssertEqual(true, solution.isBalancedTree_Solution1(node1))
        XCTAssertEqual(true, solution.isBalancedTree_Solution2(node1))
    }
    
    // 没有节点
    func testCase7()
    {
        XCTAssertEqual(true, solution.isBalancedTree_Solution1(nil))
        XCTAssertEqual(true, solution.isBalancedTree_Solution2(nil))
    }
}

UnitTests.defaultTestSuite.run()


