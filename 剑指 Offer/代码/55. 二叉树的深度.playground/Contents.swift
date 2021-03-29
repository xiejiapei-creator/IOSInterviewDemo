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
     返回二叉树的深度
     解法：利用递归，比较左右子树的深度，取较大者
     - Parameters:
        - root: 二叉树根节点
     - Returns: 深度
     */
    func treeDepth(_ rootNode: BinaryTreeNode?) -> Int
    {
        // 叶子节点就返回深度为0
        guard rootNode != nil else { return 0 }
        
        // 通过递归的方式获取左右子树的深度
        let leftTreeDepth = treeDepth(rootNode?.left)
        let rightTreeDepth = treeDepth(rootNode?.right)
        
        // 如果既有右子树又有左子树，那么该树的深度就是其左、右子树深度的较大值再加1
        return leftTreeDepth > rightTreeDepth ? leftTreeDepth + 1 : rightTreeDepth + 1
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
        let node7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node5 = BinaryTreeNode(value: 5, left: node7, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: node6)
        let node2 = BinaryTreeNode(value: 2, left: node4, right: node5)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: node3)
        
        XCTAssertEqual(4, solution.treeDepth(node1))
    }
    

    func testCase2()
    {
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: node5, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: node4, right: nil)
        let node2 = BinaryTreeNode(value: 2, left: node3, right: nil)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: nil)
        
        XCTAssertEqual(5, solution.treeDepth(node1))
    }

    func testCase3()
    {
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: node5)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: node4)
        let node2 = BinaryTreeNode(value: 2, left: nil, right: node3)
        let node1 = BinaryTreeNode(value: 1, left: nil, right: node2)
        
        XCTAssertEqual(5, solution.treeDepth(node1))
    }
    
    // 树中只有1个结点
    func testCase4()
    {
        let node1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        XCTAssertEqual(1, solution.treeDepth(node1))
    }
    
    // 树中没有结点
    func testCase5()
    {
        XCTAssertEqual(0, solution.treeDepth(nil))
    }
}

UnitTests.defaultTestSuite.run()
 
