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
     以中序方式序列化二叉树
     - Parameters:
        - rootNode: 树的根节点
     - Returns: 序列化之后的字符串
     */
    func serializeBinaryTree(_ rootNode: BinaryTreeNode?) -> String
    {
        // 初始化序列内容为空，这样是为了给外界提供便利方法
        serializeBinaryTreeCore(node: rootNode, result: "")
    }
    
    /**
     以中序遍历方式序列化二叉树
     - Parameters:
        - rootNode: 树节点
        - result: 初始序列内容
     - Returns: 序列化之后的内容
     */
    private func serializeBinaryTreeCore(node: BinaryTreeNode?,result: String) -> String
    {
        // 倘若节点为空则将序列内容添加为nil
        if node == nil
        {
            return result + "nil,"
        }
        
        // 否则将节点值作为序列内容加入其中
        var result = result
        result += "\(node!.value),"
        
        // 通过递归方式进行中序遍历
        result = serializeBinaryTreeCore(node: node!.left, result: result)// 将左子树进行序列化
        return serializeBinaryTreeCore(node: node!.right, result: result)// 将右子树进行序列化
    }
    
    /**
     将中序序列反序列化为二叉树
     - Parameters:
        - serializedString: 序列化内容
     - Returns: 二叉树根节点
     */
    func deserializeBinaryTree(_ serializedString: String) -> BinaryTreeNode?
    {
        return deserializeBinaryTreeCore(serializedString).node
    }
    
    /**
     将中序序列反序列化为二叉树
     - Parameters:
        - serializedString: 序列化内容
     - Returns: (反序列化之后的根节点, 剩余未序列化内容)
     */
    private func deserializeBinaryTreeCore(_ serializedString: String) -> (node: BinaryTreeNode?, serializedString:String)
    {
        // 根据序列化内容获取第一个节点值
        let firstNodeResult = getFirstNode(serializedString)
        
        // 获取剩余序列化内容
        var serializedString = firstNodeResult.serializedString
        
        // 将第一个节点的数值转化为二叉树节点
        var node: BinaryTreeNode? = nil
        if firstNodeResult.isNumber
        {
            node = BinaryTreeNode(value: firstNodeResult.value, left: nil, right: nil)
            
            // 通过递归的方式获取左子树的节点
            let deserializeLeftResult = deserializeBinaryTreeCore(serializedString)
            serializedString = deserializeLeftResult.serializedString
            node?.left = deserializeLeftResult.node
            
            // 通过递归的方式获取右子树的节点
            let deserializeRightResult = deserializeBinaryTreeCore(serializedString)
            serializedString = deserializeRightResult.serializedString
            node?.right = deserializeRightResult.node
        }
        
        return (node: node, serializedString: serializedString)
    }
    
    
    /**
     根据序列化内容获取第一个节点值（nil或数值）
     - Parameters:
        - serializedString: 序列化内容
     - Returns: (是否数字, 值, 剩余序列化内容)
     */
    private func getFirstNode(_ serializedString: String) -> (isNumber: Bool, value: Int, serializedString: String)
    {
        var serializedString = serializedString
        
        // 序列化内容为空
        if serializedString == ""
        {
            return (isNumber: false, value: -1, serializedString: serializedString)
        }
        
        // 将序列化内容切割开，得到所有节点值
        var nodes = serializedString.split(separator: ",")
        
        // 将第一个节点从序列化内容中移除
        let firstNode = nodes.removeFirst()
        
        // 将移除第一个节点后的序列化内容重新拼接起来
        serializedString = nodes.joined(separator: ",")
        
        // 将移除的第一个节点的字符串转化为数值并返回
        if firstNode != "nil"
        {
            let value = Int(firstNode)
            return (isNumber: true, value: value!, serializedString: serializedString)
        }
        
        // 第一个节点的字符串为nil
        return (isNumber: false, value: -1, serializedString: serializedString)
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
    
    // 判断两颗二叉树是否相同
    func isBinaryTreeEqual(_ node1: BinaryTreeNode?, _ node2: BinaryTreeNode?) -> Bool
    {
        if node1 == nil && node2 == nil
        {
            return true
        }
        
        if node1 != nil && node2 == nil
        {
            return false
        }
        
        if node1 == nil && node2 != nil
        {
            return false
        }
        
        if node1?.value != node2?.value
        {
            return false
        }
        
        return isBinaryTreeEqual(node1?.left, node2?.left) &&
            isBinaryTreeEqual(node1?.right, node2?.right)
    }
    
    // 完全二叉树
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
        
        XCTAssertEqual(solution.serializeBinaryTree(node_8),"8,6,5,nil,nil,7,nil,nil,10,9,nil,nil,11,nil,nil,")
        
        let node = solution.deserializeBinaryTree("8,6,5,nil,nil,7,nil,nil,10,9,nil,nil,11,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_8))
    }

    // 只有左子树
    func testCase2()
    {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        node_5.left = node_4
        node_4.left = node_3
        node_3.left = node_2
        XCTAssertEqual(solution.serializeBinaryTree(node_5),"5,4,3,2,nil,nil,nil,nil,nil,")

        let node = solution.deserializeBinaryTree("5,4,3,2,nil,nil,nil,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_5))
    }

    // 只有右子树
    func testCase3()
    {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        node_5.right = node_4
        node_4.right = node_3
        node_3.right = node_2
        XCTAssertEqual(solution.serializeBinaryTree(node_5),"5,nil,4,nil,3,nil,2,nil,nil,")

        let node = solution.deserializeBinaryTree("5,nil,4,nil,3,nil,2,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_5))
    }

    // 只有一个节点
    func testCase4()
    {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        XCTAssertEqual(solution.serializeBinaryTree(node_5),"5,nil,nil,")

        let node = solution.deserializeBinaryTree("5,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_5))
    }

    func testCase5()
    {
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 5, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.left = node_4
        node_4.left = node_5
        node_5.left = node_6
        node_5.right = node_7
        node_6.left = node_8
        node_7.right = node_9
        XCTAssertEqual(solution.serializeBinaryTree(node_1),"5,nil,5,nil,5,5,5,5,5,nil,nil,nil,5,nil,5,nil,nil,nil,nil,")

        let node = solution.deserializeBinaryTree("5,nil,5,nil,5,5,5,5,5,nil,nil,nil,5,nil,5,nil,nil,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_1))
    }
}

UnitTests.defaultTestSuite.run()
 
