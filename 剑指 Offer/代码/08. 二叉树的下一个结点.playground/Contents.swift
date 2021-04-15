import Foundation
import XCTest

class BinaryTreeNode: Equatable
{
    var parentNode: BinaryTreeNode?// 父节点，可能不存在
    var leftNode: BinaryTreeNode?// 左节点，可能不存在
    var rightNode: BinaryTreeNode?// 右节点，可能不存在
    var value: Int// 当前节点的值
    
    init(value: Int, parentNode: BinaryTreeNode?, leftNode: BinaryTreeNode?, rightNode: BinaryTreeNode?)
    {
        self.value = value
        self.parentNode = parentNode
        self.leftNode = leftNode
        self.rightNode = rightNode
    }
    
    // Global function 'XCTAssertEqual(_:_:_:file:line:)' requires that 'BinaryTreeNode' conform to 'Equatable'
    // 两个对象相互比较需要重写==运算符
    static func == (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool
    {
        return lhs.value == rhs.value
    }
}

class Solution
{
    /**
     给定一棵二叉树的某节点，查找中序序列该节点的下一节点
     - Parameters:
        - node: 给定节点
     - Returns: 中序序列的下一个节点
     */
    func getNextNode(_ node: BinaryTreeNode) -> BinaryTreeNode?
    {
        var tempNode = node
        
        // 如果一个节点有右子树，那么它的下一个节点就是它的右子树中的最左子节点
        if (tempNode.rightNode != nil)
        {
            tempNode = tempNode.rightNode!
            
            while (tempNode.leftNode != nil)
            {
                tempNode = tempNode.leftNode!
            }
            
            return tempNode
        }
        
        // 当前节点没有父节点，那么当前节点没有下一节点
        if (tempNode.parentNode == nil)
        {
            return nil
        }
        
        // 如果节点是它父节点的左子节点，那么它的下一个节点就是它的父节点
        if (tempNode == tempNode.parentNode!.leftNode)
        {
            return tempNode.parentNode!
        }
        // 沿着指向父节点的指针一直向上遍历，直到找到一个是它父节点的左子节点的节点
        else
        {
            var localNode = tempNode.parentNode!
            
            while (localNode.parentNode != nil)
            {
                if (localNode == localNode.parentNode!.leftNode)
                {
                    return localNode.parentNode!
                }
                
                localNode = localNode.parentNode!
            }
            
            return nil
        }
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
        let node_8 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_6 = BinaryTreeNode(value: 6, parentNode: node_8, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 5, parentNode: node_6, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 7, parentNode: node_6, leftNode: nil, rightNode: nil)
        node_6.leftNode = node_5
        node_6.rightNode = node_7
        
        let node_10 = BinaryTreeNode(value: 10, parentNode: node_8, leftNode: nil, rightNode: nil)
        let node_9 = BinaryTreeNode(value: 9, parentNode: node_10, leftNode: nil, rightNode: nil)
        let node_11 = BinaryTreeNode(value: 11, parentNode: node_10, leftNode: nil, rightNode: nil)
        node_10.leftNode = node_9
        node_10.rightNode = node_11
        
        node_8.leftNode = node_6
        node_8.rightNode = node_10
        
        XCTAssertEqual(solution.getNextNode(node_8)!, node_9)
        XCTAssertEqual(solution.getNextNode(node_6)!, node_7)
        XCTAssertEqual(solution.getNextNode(node_10)!, node_11)
        XCTAssertEqual(solution.getNextNode(node_5)!, node_6)
        XCTAssertEqual(solution.getNextNode(node_7)!, node_8)
        XCTAssertEqual(solution.getNextNode(node_9)!, node_10)
        XCTAssertEqual(solution.getNextNode(node_11), nil)
    }
    
    // 所有节点都没有右子节点的二叉树
    func testCase2()
    {
        let node_5 = BinaryTreeNode(value: 5, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 4, parentNode: node_5, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 3, parentNode: node_4, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 2, parentNode: node_3, leftNode: nil, rightNode: nil)
        node_5.leftNode = node_4
        node_4.leftNode = node_3
        node_3.leftNode = node_2
        
        XCTAssertEqual(solution.getNextNode(node_5), nil)
        XCTAssertEqual(solution.getNextNode(node_4)!, node_5)
        XCTAssertEqual(solution.getNextNode(node_3)!, node_4)
        XCTAssertEqual(solution.getNextNode(node_2)!, node_3)
    }
    
    // 所有节点都没有左子节点的二叉树
    func testCase3()
    {
        let node_2 = BinaryTreeNode(value: 2, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 3, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 4, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 5, parentNode: node_4, leftNode: nil, rightNode: nil)
        node_2.rightNode = node_3
        node_3.rightNode = node_4
        node_4.rightNode = node_5
        
        XCTAssertEqual(solution.getNextNode(node_5), nil)
        XCTAssertEqual(solution.getNextNode(node_4)!, node_5)
        XCTAssertEqual(solution.getNextNode(node_3)!, node_4)
        XCTAssertEqual(solution.getNextNode(node_2)!, node_3)
    }
    
    // 只有一个节点的二叉树
    func testCase4()
    {
        let node_5 = BinaryTreeNode(value: 5, parentNode: nil, leftNode: nil, rightNode: nil)
        XCTAssertEqual(solution.getNextNode(node_5), nil)
    }
}

UnitTests.defaultTestSuite.run()



 
func getNextNode(_ node: BinaryTreeNode) -> BinaryTreeNode?
{
    var tempNode = node
    
    // 如果一个节点有右子树，那么它的下一个节点就是它的右子树中的最左子节点
    if (tempNode.rightNode != nil)
    {
        tempNode = tempNode.rightNode!
        
        while (tempNode.leftNode != nil)
        {
            tempNode = tempNode.leftNode!
        }
        
        return tempNode
    }
    
    // 当前节点没有父节点，那么当前节点没有下一节点
    if (tempNode.parentNode == nil)
    {
        return nil
    }
    
    // 如果节点是它父节点的左子节点，那么它的下一个节点就是它的父节点
    if (tempNode == tempNode.parentNode!.leftNode)
    {
        return tempNode.parentNode!
    }
    // 沿着指向父节点的指针一直向上遍历，直到找到一个是它父节点的左子节点的节点
    else
    {
        var localNode = tempNode.parentNode!
        
        while (localNode.parentNode != nil)
        {
            if (localNode == localNode.parentNode!.leftNode)
            {
                return localNode.parentNode!
            }
            
            localNode = localNode.parentNode!
        }
        
        return nil
    }
}
