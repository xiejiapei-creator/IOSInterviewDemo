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
     返回二叉搜索树中第K大的节点
     解法：利用二叉搜索树的中序遍历让元素从小到大排列
     - Parameters:
        - rootNode: 二叉搜索树根节点
        - k：第K大
     - Returns: (node: 第K大的节点, newK：新的k值)
     
     */
    func kthNode(rootNode: BinaryTreeNode, k: Int) -> (node: BinaryTreeNode?, newK: Int)
    {
        guard k > 0 else { return (nil, k) }
        
        // 寻找的第K大的节点
        var targetNode: BinaryTreeNode? = nil
        var newK = k
        
        // 根据中序遍历的顺序，先递归遍历左子树
        if rootNode.left != nil
        {
            (targetNode, newK) = kthNode(rootNode: rootNode.left!, k: newK)
        }
        
        // 在二叉搜索树中左子树的值均小于根节点，如果在左子树中没有找到第K大的节点
        if targetNode == nil
        {
            // newK作为计数器，当newK减少为1的时候，此时的rootNode就是找到的第K大的节点
            if newK == 1
            {
                targetNode = rootNode
            }
            
            // newK最终会减少为0，当减为0的时候退出递归
            newK -= 1
        }
        
        // 如果还没有找到第K大的节点，则最后递归遍历右子树
        if targetNode == nil && rootNode.right != nil
        {
            (targetNode, newK) = kthNode(rootNode: rootNode.right!, k: newK)
        }
        
        return (targetNode, newK)
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
        let node_8 = BinaryTreeNode(value: 8, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node_10 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 9, left: nil, right: nil)
        let node_11 = BinaryTreeNode(value: 11, left: nil, right: nil)
        node_8.left = node_6
        node_8.right = node_10
        node_6.left = node_5
        node_6.right = node_7
        node_10.left = node_9
        node_10.right = node_11

        XCTAssertEqual(nil, solution.kthNode(rootNode: node_8, k: 0).node)
        XCTAssertEqual(node_5, solution.kthNode(rootNode: node_8, k: 1).node)
        XCTAssertEqual(node_6, solution.kthNode(rootNode: node_8, k: 2).node!)
        XCTAssertEqual(node_7, solution.kthNode(rootNode: node_8, k: 3).node!)
        XCTAssertEqual(node_8, solution.kthNode(rootNode: node_8, k: 4).node!)
        XCTAssertEqual(node_9, solution.kthNode(rootNode: node_8, k: 5).node!)
        XCTAssertEqual(node_10, solution.kthNode(rootNode: node_8, k: 6).node!)
        XCTAssertEqual(node_11, solution.kthNode(rootNode: node_8, k: 7).node!)
    }

    func testCase2()
    {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_5.left = node_4
        node_4.left = node_3
        node_3.left = node_2
        node_2.left = node_1

        XCTAssertEqual(nil, solution.kthNode(rootNode: node_5, k: 0).node)
        XCTAssertEqual(node_1, solution.kthNode(rootNode: node_5, k: 1).node)
        XCTAssertEqual(node_2, solution.kthNode(rootNode: node_5, k: 2).node)
        XCTAssertEqual(node_3, solution.kthNode(rootNode: node_5, k: 3).node)
        XCTAssertEqual(node_4, solution.kthNode(rootNode: node_5, k: 4).node)
        XCTAssertEqual(node_5, solution.kthNode(rootNode: node_5, k: 5).node)
    }

    func testCase3()
    {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5

        XCTAssertEqual(nil, solution.kthNode(rootNode: node_1, k: 0).node)
        XCTAssertEqual(node_1, solution.kthNode(rootNode: node_1, k: 1).node)
        XCTAssertEqual(node_2, solution.kthNode(rootNode: node_1, k: 2).node)
        XCTAssertEqual(node_3, solution.kthNode(rootNode: node_1, k: 3).node)
        XCTAssertEqual(node_4, solution.kthNode(rootNode: node_1, k: 4).node)
        XCTAssertEqual(node_5, solution.kthNode(rootNode: node_1, k: 5).node)
    }

    func testCase4()
    {
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        XCTAssertEqual(nil, solution.kthNode(rootNode: node_1, k: 0).node)
        XCTAssertEqual(node_1, solution.kthNode(rootNode: node_1, k: 1).node)
        XCTAssertEqual(nil, solution.kthNode(rootNode: node_1, k: 2).node)
    }
}

UnitTests.defaultTestSuite.run()
