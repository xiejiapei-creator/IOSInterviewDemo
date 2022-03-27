import Foundation
import XCTest

// 二叉树结点
class BinaryTreeNode: Equatable
{
    var parentNode: BinaryTreeNode?
    var leftNode: BinaryTreeNode?
    var rightNode: BinaryTreeNode?
    var value: Int
    
    init(value: Int, parentNode: BinaryTreeNode?, leftNode: BinaryTreeNode?, rightNode: BinaryTreeNode?)
    {
        self.value = value
        self.parentNode = parentNode
        self.leftNode = leftNode
        self.rightNode = rightNode
    }
    
    static func ==(leftNode: BinaryTreeNode, rightNode: BinaryTreeNode) -> Bool
    {
        return leftNode.value == rightNode.value
    }
}

class Solution
{
    /**
     判断树2是否是树1的子树
     - Parameters:
        - rootNode1: 树1
        - rootNode2: 树2
     - Returns: 树2是否是树1的子树
     */
    func isSubTree(_ rootNode1: BinaryTreeNode?,_ rootNode2: BinaryTreeNode?) ->  Bool
    {
        // 两棵二叉树的一个或者两个根节点为空
        if rootNode2 == nil
        {
            return true
        }
        
        if rootNode1 == nil
        {
            return false
        }
        
        var result = false

        // 如果发现某一节点的值和树B的头节点的值相同，则调用isTree1ContainTree2进行第二步判断
        if rootNode1 == rootNode2
        {
            result = isTree1ContainTree2(rootNode1, rootNode2)
        }
        
        // 递归调用自身遍历二叉树A：在树A中查找与树B根节点的值一样的节点
        if !result
        {
            result = isSubTree(rootNode1!.leftNode, rootNode2)
        }
        
        if !result
        {
            result = isSubTree(rootNode1!.rightNode, rootNode2)
        }
        
        return result
    }
    
    /**
     判断树A中以R为根节点的子树是不是和树B具有相同的结构
     - Parameters:
        - rootNode1: 树1
        - rootNode2: 树2
     - Returns: 是否包含
     */
    private func isTree1ContainTree2(_ rootNode1: BinaryTreeNode?, _ rootNode2: BinaryTreeNode?) -> Bool
    {
        // 如果节点R的值和树B的根节点不相同，则以R为根节点的子树和树B肯定不具有相同的节点
        if rootNode2 == nil
        {
            // 判断树B是否为nil需要放在树A前面，因为当树中结点只有左/右子结点的时候
            // 判断右/左节点是否相等需要返回true，如果判断树A是否为nil放在前面则会返回false导致最终结果返回错误
            return true
        }
        
        if rootNode1 == nil
        {
            return false
        }
 
        if rootNode1! != rootNode2!
        {
            return false
        }
        
        // 如果它们的值相同，则递归地判断它们各自的左右节点的值是不是相同。递归的终止条件是我们到达了树A或者树B的叶节点
        return isTree1ContainTree2(rootNode1!.leftNode, rootNode2!.leftNode) && isTree1ContainTree2(rootNode1!.rightNode, rootNode2!.rightNode)
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
    
    // 树中结点含有分叉，树B是树A的子结构
    func testCase1()
    {
        // 树A
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 8, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 7, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 9, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 2, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_6 = BinaryTreeNode(value: 4, parentNode: node_5, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 7, parentNode: node_5, leftNode: nil, rightNode: nil)
        node_1.leftNode = node_2
        node_1.rightNode = node_3
        node_2.leftNode = node_4
        node_2.rightNode = node_5
        node_5.leftNode = node_6
        node_5.rightNode = node_7
        
        // 树B
        let node_8 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_9 = BinaryTreeNode(value: 9, parentNode: node_8, leftNode: nil, rightNode: nil)
        let node_10 = BinaryTreeNode(value: 2, parentNode: node_8, leftNode: nil, rightNode: nil)
        node_8.leftNode = node_9
        node_8.rightNode = node_10
        
        XCTAssertTrue(solution.isSubTree(node_1, node_8))
    }
    // 树中结点含有分叉，树B不是树A的子结构

    func testCase2()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 8, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 7, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 9, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 3, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_6 = BinaryTreeNode(value: 4, parentNode: node_5, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 7, parentNode: node_5, leftNode: nil, rightNode: nil)
        node_1.leftNode = node_2
        node_1.rightNode = node_3
        node_2.leftNode = node_4
        node_2.rightNode = node_5
        node_5.leftNode = node_6
        node_5.rightNode = node_7
        
        let node_8 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_9 = BinaryTreeNode(value: 9, parentNode: node_8, leftNode: nil, rightNode: nil)
        let node_10 = BinaryTreeNode(value: 2, parentNode: node_8, leftNode: nil, rightNode: nil)
        node_8.leftNode = node_9
        node_8.rightNode = node_10
        
        XCTAssertFalse(solution.isSubTree(node_1, node_8))
    }
    
    // 树中结点只有左子结点，树B是树A的子结构
    func testCase3()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 8, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 9, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 2, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 5, parentNode: node_4, leftNode: nil, rightNode: nil)
        node_1.leftNode = node_2
        node_2.leftNode = node_3
        node_3.leftNode = node_4
        node_4.leftNode = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 9, parentNode: node_6, leftNode: nil, rightNode: nil)
        let node_8 = BinaryTreeNode(value: 2, parentNode: node_7, leftNode: nil, rightNode: nil)
        node_6.leftNode = node_7
        node_7.leftNode = node_8
        
        XCTAssertTrue(solution.isSubTree(node_1, node_6))
    }
    
    // 树中结点只有左子结点，树B不是树A的子结构
    func testCase4()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 8, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 9, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 2, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 5, parentNode: node_4, leftNode: nil, rightNode: nil)
        
        node_1.leftNode = node_2
        node_2.leftNode = node_3
        node_3.leftNode = node_4
        node_4.leftNode = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 9, parentNode: node_6, leftNode: nil, rightNode: nil)
        let node_8 = BinaryTreeNode(value: 3, parentNode: node_7, leftNode: nil, rightNode: nil)
        node_6.leftNode = node_7
        node_7.leftNode = node_8
        
        XCTAssertFalse(solution.isSubTree(node_1, node_6))
    }
    
    // 树中结点只有右子结点，树B是树A的子结构
    func testCase5()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 8, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 9, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 2, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 5, parentNode: node_4, leftNode: nil, rightNode: nil)
        
        node_1.rightNode = node_2
        node_2.rightNode = node_3
        node_3.rightNode = node_4
        node_4.rightNode = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 9, parentNode: node_6, leftNode: nil, rightNode: nil)
        let node_8 = BinaryTreeNode(value: 2, parentNode: node_7, leftNode: nil, rightNode: nil)
        node_6.rightNode = node_7
        node_7.rightNode = node_8
        
        XCTAssertTrue(solution.isSubTree(node_1, node_6))
    }
    
    // 树A中结点只有右子结点，树B不是树A的子结构
    func testCase6()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 8, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 9, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 2, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 5, parentNode: node_4, leftNode: nil, rightNode: nil)
        
        node_1.rightNode = node_2
        node_2.rightNode = node_3
        node_3.rightNode = node_4
        node_4.rightNode = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 9, parentNode: node_6, leftNode: nil, rightNode: nil)
        let node_8 = BinaryTreeNode(value: 9, parentNode: node_7, leftNode: nil, rightNode: nil)
        let node_9 = BinaryTreeNode(value: 2, parentNode: node_7, leftNode: nil, rightNode: nil)
        node_6.rightNode = node_7
        node_7.leftNode = node_8
        node_7.rightNode = node_9
        
        XCTAssertFalse(solution.isSubTree(node_1, node_6))
    }
    
    // 树A为空
    func testCase7()
    {
        let node_6 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 9, parentNode: node_6, leftNode: nil, rightNode: nil)
        let node_8 = BinaryTreeNode(value: 3, parentNode: node_7, leftNode: nil, rightNode: nil)
        let node_9 = BinaryTreeNode(value: 2, parentNode: node_8, leftNode: nil, rightNode: nil)
        node_6.rightNode = node_7
        node_7.rightNode = node_8
        node_8.rightNode = node_9
        
        XCTAssertFalse(solution.isSubTree(nil, node_6))
    }
    
    // 树B为空
    func testCase8()
    {
        let node_6 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 9, parentNode: node_6, leftNode: nil, rightNode: nil)
        let node_8 = BinaryTreeNode(value: 3, parentNode: node_7, leftNode: nil, rightNode: nil)
        let node_9 = BinaryTreeNode(value: 2, parentNode: node_8, leftNode: nil, rightNode: nil)
        node_6.rightNode = node_7
        node_7.rightNode = node_8
        node_8.rightNode = node_9
        
        XCTAssertFalse(solution.isSubTree(node_6, nil))
    }
    
    // 树A和B都为空
    func testCase9()
    {
        XCTAssertFalse(solution.isSubTree(nil, nil))
    }
}

UnitTests.defaultTestSuite.run()
