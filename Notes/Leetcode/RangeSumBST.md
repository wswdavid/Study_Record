# 938 二叉搜索树范围和 Range Sum of Binary Search Tree (BST)

Tag: 递归，二叉树

## Q

```
给定二叉搜索树的根结点 root，返回 L 和 R（含）之间的所有结点的值的和。

二叉搜索树保证具有唯一的值。



示例 1：

输入：root = [10,5,15,3,7,null,18], L = 7, R = 15
输出：32
示例 2：

输入：root = [10,5,15,3,7,13,18,1,null,6], L = 6, R = 10
输出：23


提示：

树中的结点数量最多为 10000 个。
最终的答案保证小于 2^31。
```

## A

在二叉搜索树中寻找大于L及小于R的节点值的和。

已知树为BST，根据BST的特征：**左子节点的值<当前节点的值<右子节点的值**。

## 递归 Recursion

使用递归，分3种情况：

1. 当前值小于左约束
2. 当前值大于右约束
3. 当前值为None
4. else

```python
class Solution:
    def rangeSumBST(self, node: TreeNode, L: int, R: int) -> int:

        if node == None:
            return 0
        if node.val < L:
            return self.rangeSumBST(node.right, L, R)
        if node.val > R:
            return self.rangeSumBST(node.left, L, R)
        return node.val + self.rangeSumBST(node.left, L, R) + self.rangeSumBST(node.right, L, R)
```

## BFS/DFS

用BFS/DFS遍历树每一个节点，若节点在约束范围中，则将节点值累加。
