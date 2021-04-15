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
     以二维数组的形式分层返回按从上到下从左到右的顺序的二叉树所有节点的值
     二维数组的第一个子数组的元素为根节点，第二个子数组为第二层的所有节点，以此类推
     - Parameters:
        - rootNode: 二叉树根节点
     - Returns: 二叉树的所有节点值
     */
    func printBinaryTree(_ rootNode: BinaryTreeNode) -> [[Int]]
    {
        // 以二维数组的形式分层返回一定顺序的二叉树所有节点的值
        var resultMatrix = [[Int]]()
        
        // 先进先出的辅助队列
        var dataQueue = [BinaryTreeNode]()
        dataQueue.append(rootNode)
        
        // 表示下一层节点的数目，初始值为根节点数量为1
        var nextLevel = 1
        
        // 层数，0表示第一层
        var levelCount = 0

        // 打印完所有的节点
        while dataQueue.count > 0
        {
            // 表示在当前层中还没有打印的节点数，其值来自于之前记录的下层值
            var toBePrinted = nextLevel
            
            // 将下层节点数量重置为0
            nextLevel = 0

            // 当前层的打印值
            var currentLevelResult = [Int]()
            
            // 当 toBePrinted 变成0时，表示当前层的所有节点已经打印完毕，可以继续打印下一层
            while toBePrinted > 0
            {
                // 如果一个节点有子节点，则每把一个子节点加入队列，同时把变量 nextLevel 加1
                let firstNode = dataQueue.first!
                
                if firstNode.left != nil
                {
                    dataQueue.append(firstNode.left!)
                    nextLevel += 1
                }
                
                if firstNode.right != nil
                {
                    dataQueue.append(firstNode.right!)
                    nextLevel += 1
                }
                
                // 每打印一个节点，toBePrinted 减1
                currentLevelResult.append(dataQueue.removeFirst().value)
                toBePrinted -= 1
            }
            
            // 将当前层的打印值加入到结果之中
            resultMatrix.append(currentLevelResult)
            
            levelCount += 1
        }
        
        return resultMatrix
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
        
        XCTAssertEqual(solution.printBinaryTree(node_1), [[8],[6,10],[5,7,9,11]])
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

        XCTAssertEqual(solution.printBinaryTree(node_1), [[5],[4],[3],[2]])
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

        XCTAssertEqual(solution.printBinaryTree(node_1), [[5],[4],[3],[2]])
    }

    func testCase4()
    {
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        XCTAssertEqual(solution.printBinaryTree(node_1), [[5]])
    }

    func testCase5()
    {
        let node_1 = BinaryTreeNode(value: 100, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 50, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 150, parent: node_2, left: nil, right: nil)
        node_1.left = node_2
        node_2.right = node_3

        XCTAssertEqual(solution.printBinaryTree(node_1), [[100],[50],[150]])
    }
}

UnitTests.defaultTestSuite.run()


