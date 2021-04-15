import Foundation
import XCTest

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
     实现二叉树的镜像（递归左右翻转）
     - Parameters:
        - rootNode: 树的根节点
     - Returns: 镜像之后生成的树的根节点
     */
    func mirrorTreeRecursively(_ rootNode: BinaryTreeNode?)
    {
        // 空二叉树
        guard let rootNode = rootNode else
        {
            return
        }
        
        // 只有一个结点的二叉树
        guard rootNode.leftNode != nil || rootNode.rightNode != nil else
        {
            return
        }
        
        // 交换根节点的左右子树
        (rootNode.leftNode, rootNode.rightNode) = (rootNode.rightNode, rootNode.leftNode)
        
        // 当交换完所有非叶节点的左、右子节点之后，就得到了树的镜像
        if rootNode.leftNode != nil
        {
            mirrorTreeRecursively(rootNode.leftNode)
        }
        
        if rootNode.rightNode != nil
        {
            mirrorTreeRecursively(rootNode.rightNode)
        }
    }
    
    /**
     实现二叉树的镜像（循环）
     - Parameters:
        - root: 树的根节点
     - Returns: 镜像之后生成的树的根节点
     */
    func mirrorTreeIteratively(_ rootNode: BinaryTreeNode?)
    {
        // 空二叉树
        guard let rootNode = rootNode else
        {
            return
        }
        
        // 把 nodes 当作栈使用
        var nodes = [BinaryTreeNode]()
        nodes.append(rootNode)
        
        while nodes.count > 0
        {
            // 弹出栈顶节点（第一个弹出的是根节点）
            let lastNode = nodes.removeLast()
            
            // 交换非叶节点的左右子树（第一个交换的是根节点的左右子树）
            (lastNode.leftNode, lastNode.rightNode) = (lastNode.rightNode, lastNode.leftNode)
            
            // 压入下一个非叶节点
            if lastNode.leftNode != nil
            {
                nodes.append(lastNode.leftNode!)
            }
            
            if lastNode.rightNode != nil
            {
                nodes.append(lastNode.rightNode!)
            }
        }
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }


    func testCase1()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 6, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 10, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 5, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 7, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_6 = BinaryTreeNode(value: 9, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_7 = BinaryTreeNode(value: 11, parentNode: node_3, leftNode: nil, rightNode: nil)
        node_1.leftNode = node_2
        node_1.rightNode = node_3
        node_2.leftNode = node_4
        node_2.rightNode = node_5
        node_3.leftNode = node_6
        node_3.rightNode = node_7
        
        solution.mirrorTreeRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.leftNode, node_3)
        XCTAssertEqual(node_1.rightNode, node_2)
        XCTAssertEqual(node_3.leftNode, node_7)
        XCTAssertEqual(node_3.rightNode, node_6)
        XCTAssertEqual(node_2.leftNode, node_5)
        XCTAssertEqual(node_2.rightNode, node_4)
        
        // 镜像回去，测试循环的方法
        solution.mirrorTreeRecursively(node_1)
        solution.mirrorTreeIteratively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.leftNode, node_3)
        XCTAssertEqual(node_1.rightNode, node_2)
        XCTAssertEqual(node_3.leftNode, node_7)
        XCTAssertEqual(node_3.rightNode, node_6)
        XCTAssertEqual(node_2.leftNode, node_5)
        XCTAssertEqual(node_2.rightNode, node_4)
    }
    
    // 二叉树除叶子结点之外，左右的结点都有且只有一个左子结点
    func testCase2()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 7, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 6, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 5, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 4, parentNode: node_4, leftNode: nil, rightNode: nil)
        node_1.leftNode = node_2
        node_2.leftNode = node_3
        node_3.leftNode = node_4
        node_4.leftNode = node_5
        
        solution.mirrorTreeRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.rightNode, node_2)
        XCTAssertEqual(node_2.rightNode, node_3)
        XCTAssertEqual(node_3.rightNode, node_4)
        XCTAssertEqual(node_4.rightNode, node_5)
        
        solution.mirrorTreeRecursively(node_1)
        solution.mirrorTreeIteratively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.rightNode, node_2)
        XCTAssertEqual(node_2.rightNode, node_3)
        XCTAssertEqual(node_3.rightNode, node_4)
        XCTAssertEqual(node_4.rightNode, node_5)
        
    }
    
    // 除叶子结点之外，左右的结点都有且只有一个右子结点
    func testCase3()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        let node_2 = BinaryTreeNode(value: 7, parentNode: node_1, leftNode: nil, rightNode: nil)
        let node_3 = BinaryTreeNode(value: 6, parentNode: node_2, leftNode: nil, rightNode: nil)
        let node_4 = BinaryTreeNode(value: 5, parentNode: node_3, leftNode: nil, rightNode: nil)
        let node_5 = BinaryTreeNode(value: 4, parentNode: node_4, leftNode: nil, rightNode: nil)
        node_1.rightNode = node_2
        node_2.rightNode = node_3
        node_3.rightNode = node_4
        node_4.rightNode = node_5
        
        solution.mirrorTreeRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.leftNode, node_2)
        XCTAssertEqual(node_2.leftNode, node_3)
        XCTAssertEqual(node_3.leftNode, node_4)
        XCTAssertEqual(node_4.leftNode, node_5)
        
        solution.mirrorTreeRecursively(node_1)
        solution.mirrorTreeIteratively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.leftNode, node_2)
        XCTAssertEqual(node_2.leftNode, node_3)
        XCTAssertEqual(node_3.leftNode, node_4)
        XCTAssertEqual(node_4.leftNode, node_5)
    }
    
    // 空二叉树
    func testCase4()
    {
        let node_1: BinaryTreeNode? = nil
        solution.mirrorTreeRecursively(node_1)
        XCTAssertNil(node_1)

        solution.mirrorTreeRecursively(node_1)
        solution.mirrorTreeIteratively(node_1)
        XCTAssertNil(node_1)
    }
    
    // 只有一个结点的二叉树
    func testCase5()
    {
        let node_1 = BinaryTreeNode(value: 8, parentNode: nil, leftNode: nil, rightNode: nil)
        solution.mirrorTreeRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
        
        solution.mirrorTreeRecursively(node_1)
        solution.mirrorTreeIteratively(node_1)
        XCTAssertEqual(node_1.value, 8)
    }
}

UnitTests.defaultTestSuite.run()
