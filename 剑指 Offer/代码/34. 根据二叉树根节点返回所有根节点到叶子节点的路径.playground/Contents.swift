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
     查找二叉树中和为某一值的路径
     - Parameters:
        - rootNode: 树根节点
        - expectedSum: 期待的和
     - Returns: 路径上所有节点值的和为期待和的所有路径
     */
    func findSumPath(_ rootNode: BinaryTreeNode, expectedSum: Int) -> [[BinaryTreeNode]]
    {
        let allTreePath = findAllPath(rootNode)
        
        return allTreePath.filter {
            // reduce：sum初始值为0，对于每一个node的值进行累加得到总值并返回
            // filter：$0.== expectedSum 过滤掉路径的值未达到期望值的部分
            $0.reduce(0, { sum, node in return sum + node.value}) == expectedSum
        }
    }
    
    /**
     根据二叉树根节点返回所有根节点到叶子节点的路径
     - Parameters:
        - rootNode: 树根节点
     - Returns: 所有根节点到叶子节点的路径
     */
    func findAllPath(_ rootNode: BinaryTreeNode) -> [[BinaryTreeNode]]
    {
        var results = [[BinaryTreeNode]]()// 存储所有根节点到叶子节点的路径
        var stack = [[BinaryTreeNode]]()// 存储每一条路径的寻找过程
        stack.append([rootNode])// 先将根节点加入其中
        
        // 当栈非空的时候
        while !stack.isEmpty
        {
            // 从栈顶弹出之前保存的路径（右子树会先弹出）
            let nodes = stack.removeLast()

            // 如果该节点为叶节点则说明找到了一条路径将其加入到结果之中
            if nodes.last!.left == nil && nodes.last!.right == nil
            {
                results.append(nodes)
            }
            // 否则继续寻找将非空的子节点加入到路径中
            else
            {
                // 获取当前节点
                let currentNode = nodes.last!

                // 存在左子树
                if currentNode.left != nil
                {
                    var path = nodes// nodes为常量，代表的是之前的路径
                    path.append(currentNode.left!)// 将左节点加入到新路径中
                    stack.append(path)// 将新路径加入到栈顶
                }
                
                // 存在右子树
                if currentNode.right != nil
                {
                    var path = nodes// nodes为常量，代表的是之前的路径
                    path.append(currentNode.right!)// 将右节点加入到新路径中
                    stack.append(path)// 将新路径加入到栈顶
                }
            }
        }
        return results
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
    

    // 有两条路径上的结点和为22
    func testCase1()
    {
        let node_1 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 5,  left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 12, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        
        let paths = solution.findSumPath(node_1, expectedSum: 22)
        XCTAssertEqual(paths.count, 2)
        XCTAssertEqual(paths[0], [node_1, node_3])
        XCTAssertEqual(paths[1], [node_1, node_2, node_5])

    }
    
    // 没有路径上的结点和为15
    func testCase2()
    {
        let node_1 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 5,  left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 12, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5

        let paths = solution.findSumPath(node_1, expectedSum: 15)
        XCTAssertEqual(paths.count, 0)
    }


    // 有一条路径上面的结点和为15
    func testCase3()
    {
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        node_4.left = node_5

        let paths = solution.findSumPath(node_1, expectedSum: 15)
        XCTAssertEqual(paths.count, 1)
        XCTAssertEqual(paths[0], [node_1,node_2,node_3,node_4,node_5])
    }

    // 没有路径上面的结点和为16
    func testCase4()
    {
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5

        let paths = solution.findSumPath(node_1, expectedSum: 16)
        XCTAssertEqual(paths.count, 0)
    }

    // 树中只有1个结点
    func testCase5()
    {
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let paths = solution.findSumPath(node_1, expectedSum: 5)
        XCTAssertEqual(paths.count, 1)
        XCTAssertEqual(paths[0], [node_1])
    }
}

UnitTests.defaultTestSuite.run()


 

