import Foundation
import XCTest

//树结构
class TreeNode: Equatable
{
    var children: [TreeNode]
    var value: Int
    
    init(value: Int, children: [TreeNode])
    {
        self.value = value
        self.children = children
    }
    
    static func ==(left: TreeNode, right: TreeNode) -> Bool
    {
        return left.value == right.value
    }
}

class Solution
{
    /*
     查找树中两个结点的最低公共祖先
     - Parameters:
        - root: 树的根节点
        - node1: 节点1
        - node2: 节点2
     - Returns: 查找到的公共祖先
     */
    func getLastCommonParent(root: TreeNode, node1: TreeNode, node2: TreeNode) -> TreeNode?
    {
        // 创建两条路径
        var path1 = [TreeNode](), path2 = [TreeNode]()
        
        // 给两条路径赋值
        getNodePath(rootNode: root, targetNode: node1, path: &path1)
        getNodePath(rootNode: root, targetNode: node2, path: &path2)
        
        // 根据两条路径查找最后公共祖先
        return getLastCommonNode(path1: path1, path2: path2)
    }
    
    // 返回是否找到目标节点，并同时获取查找的路径
    private func getNodePath(rootNode: TreeNode, targetNode: TreeNode,  path: inout [TreeNode]) -> Bool
    {
        // 如果要查找的节点恰好是根节点则直接返回找到目标节点了，此时路径为空
        if targetNode == rootNode { return true }
        
        // 首先将根节点加入到路径当中
        path.append(rootNode)

        // 遍历根节点的所有子节点
        var found = false
        for childNode in rootNode.children
        {
            // 通过递归的方式查找目标节点
            found = getNodePath(rootNode: childNode, targetNode: targetNode, path: &path)
            
            // 在当前子节点中查找到目标节点则打破循环不再查找
            if found
            {
                break
            }
        }
        
        // 遍历完所有的子节点仍然未能查找到目标节点则从递归路径中删除当前节点回到上一级
        if !found
        {
            path.removeLast()
        }
        
        return found
    }
    
    // 根据两条路径查找最后公共祖先（两条路径都是根节点在前）
    func getLastCommonNode(path1: [TreeNode], path2: [TreeNode]) -> TreeNode?
    {
        // 用来返回的最后的公共祖先，可能并不存在
        var commonNode: TreeNode? = nil
        
        // 遍历其中一条路径，将其节点值逐个和另外一条路径中的节点值进行比较直到找到最后的公共祖先
        for index in 0 ..< path1.count
        {
            if index < path2.count && path1[index] == path2[index]
            {
                commonNode = path1[index]
            }
            else
            {
                // 返回找到的最后的公共祖先
                return commonNode
            }
        }

        return commonNode
    }
}

class UnitTests: XCTestCase
{
    let solution = Solution()
    override func setUp()
    {
        super.setUp()
    }
    
    // 形状普通的树
    func testCase1()
    {
        let node10 = TreeNode(value: 10, children: [])
        let node9 = TreeNode(value: 9, children: [])
        let node8 = TreeNode(value: 8, children: [])
        let node7 = TreeNode(value: 7, children: [])
        let node6 = TreeNode(value: 6, children: [])
        let node5 = TreeNode(value: 5, children: [node8,node9,node10])
        let node4 = TreeNode(value: 4, children: [node6,node7])
        let node3 = TreeNode(value: 3, children: [])
        let node2 = TreeNode(value: 2, children: [node4,node5])
        let node1 = TreeNode(value: 1, children: [node2,node3])
        
        XCTAssertEqual(node2, solution.getLastCommonParent(root: node1, node1: node6, node2: node8))
    }
    
    // 树退化成一个链表
    func testCase2()
    {
        let node5 = TreeNode(value: 5, children: [])
        let node4 = TreeNode(value: 4, children: [node5])
        let node3 = TreeNode(value: 3, children: [node4])
        let node2 = TreeNode(value: 2, children: [node3])
        let node1 = TreeNode(value: 1, children: [node2])

        XCTAssertEqual(node3, solution.getLastCommonParent(root: node1, node1: node4, node2: node5))
    }

    // 树退化成一个链表，并且结点6不在树中
    func testCase3()
    {
        let node5 = TreeNode(value: 5, children: [])
        let node4 = TreeNode(value: 4, children: [node5])
        let node3 = TreeNode(value: 3, children: [node4])
        let node2 = TreeNode(value: 2, children: [node3])
        let node1 = TreeNode(value: 1, children: [node2])
        let node6 = TreeNode(value: 6, children: [])

        XCTAssertEqual(nil, solution.getLastCommonParent(root: node1, node1: node4, node2: node6))
    }
}

UnitTests.defaultTestSuite.run()
