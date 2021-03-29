import Foundation
import XCTest

class BinaryTreeNode: Equatable
{
    var parent: BinaryTreeNode?
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var value: Int
    
    init(value: Int, parent: BinaryTreeNode?, left: BinaryTreeNode?, right: BinaryTreeNode?)
    {
        self.value = value
        self.parent = parent
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
     按照之字形顺序返回二叉树所有节点的值
     即第一行按照从左到右的顺序打印，第二层按照从右到左的顺序打印，第三行再按照从左到右的顺序打印，其他行以此类推。
     - Parameters:
        - rootNode: 二叉树根节点
     - Returns: 二叉树的所有节点值
     */
    func printBinaryTree(_ rootNode: BinaryTreeNode) -> [Int]
    {
        // 存储按照之字形顺序返回二叉树所有节点的值
        var result = [Int]()
        // 存储奇数行节点的栈
        var oddStack = [BinaryTreeNode]()
        // 存储偶数行节点的栈
        var evenStack = [BinaryTreeNode]()
        // 将根节点加入到偶数行栈中
        evenStack.append(rootNode)
        // 当前层数
        var levelCount = 1
        
        // 当偶数栈和奇数栈均为空时说明已经将二叉树的所有节点打印完毕
        while !oddStack.isEmpty || !evenStack.isEmpty
        {
            // 如果当前打印的是奇数层(第一层、第三层等)，则打印偶数栈中的值，先保存左子节点再保存右子节点到奇数栈里，当偶数栈为空则开启下一层
            if levelCount % 2 != 0
            {
                let lastNode = evenStack.last!
                result.append(lastNode.value)
                
                if lastNode.left != nil
                {
                    oddStack.append(lastNode.left!)
                }
                
                if lastNode.right != nil
                {
                    oddStack.append(lastNode.right!)
                }
 
                evenStack.removeLast()
                if evenStack.isEmpty
                {
                    levelCount += 1
                }
            }
            // 如果当前打印的是偶数层(第二层、第四层等)，则打印奇数栈中的值，先保存右子节点再保存左子节点到偶数栈里，当奇数栈为空则开启下一层
            else
            {
                let lastNode = oddStack.last!
                result.append(lastNode.value)
                
                if lastNode.right != nil
                {
                    evenStack.append(lastNode.right!)
                }
                
                if lastNode.left != nil
                {
                    evenStack.append(lastNode.left!)
                }
                
                oddStack.removeLast()
                if oddStack.isEmpty
                {
                    levelCount += 1
                }
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
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 10, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 9, parent: node_3, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 11, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_3.left = node_6
        node_3.right = node_7
        
        XCTAssertEqual(solution.printBinaryTree(node_1), [8,10,6,5,7,9,11])
    }
    
    func testCase2()
    {
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4

        XCTAssertEqual(solution.printBinaryTree(node_1), [5,4,3,2])
    }


    func testCase3()
    {
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4

        XCTAssertEqual(solution.printBinaryTree(node_1), [5,4,3,2])
    }

    func testCase4()
    {
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)

        XCTAssertEqual(solution.printBinaryTree(node_1), [5])
    }

    func testCase5()
    {
        let node_1 = BinaryTreeNode(value: 100, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 50, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 150, parent: node_2, left: nil, right: nil)
        node_1.left = node_2
        node_2.right = node_3

        XCTAssertEqual(solution.printBinaryTree(node_1), [100,50,150])
    }
}

UnitTests.defaultTestSuite.run()

