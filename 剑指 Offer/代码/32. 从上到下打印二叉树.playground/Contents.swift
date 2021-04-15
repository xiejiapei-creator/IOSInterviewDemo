import Foundation
import XCTest

// 二叉树结构
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
     按从上到下从左到右的顺序返回二叉树所有节点的值
     - Parameters:
        - rootNode: 二叉树根节点
     - Returns: 二叉树的所有节点值
     */
    func printBinaryTree(_ rootNode: BinaryTreeNode) -> [Int]
    {
        // 存储按从上到下从左到右的顺序遍历得到的二叉树所有节点的值
        var result = [Int]()
        
        // 使用先进先出的队列来存储子节点
        var dataQueue = [BinaryTreeNode]()
        
        // 将根节点放入其中
        dataQueue.append(rootNode)
        
        // 重复打印操作，直至队列中所有的节点都被打印出来
        while dataQueue.count > 0
        {
            let firstNode = dataQueue.first!
            
            // 到队列的头部取出最早进入队列的节点
            result.append(firstNode.value)
            
            // 每次打印一个节点的时候，如果该节点有子节点，则把该节点的子节点放到一个队列的末尾
            if firstNode.left != nil
            {
                dataQueue.append(firstNode.left!)
            }
            
            if firstNode.right != nil
            {
                dataQueue.append(firstNode.right!)
            }
            
            // 先进先出
            dataQueue.removeFirst()
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
        let node_1 = BinaryTreeNode(value: 10, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 14, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 8, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 12, parent: node_3, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 16, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_3.left = node_6
        node_3.right = node_7
        
        XCTAssertEqual(solution.printBinaryTree(node_1), [10,6,14,4,8,12,16])
    }

    func testCase2()
    {
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 1, parent: node_4, left: nil, right: nil)
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        node_4.left = node_5
        XCTAssertEqual(solution.printBinaryTree(node_1), [5,4,3,2,1])
    }

    func testCase3()
    {
        let node_1 = BinaryTreeNode(value: 1, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_4, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        XCTAssertEqual(solution.printBinaryTree(node_1), [1,2,3,4,5])
    }

    func testCase4()
    {
        let node_1 = BinaryTreeNode(value: 1, parent: nil, left: nil, right: nil)
        XCTAssertEqual(solution.printBinaryTree(node_1), [1])
    }
}

UnitTests.defaultTestSuite.run()
