# 783. 二叉搜索树结点最小距离 minDiffInBST

Tag: 递归，二叉树

## Q

```给定一个二叉搜索树的根结点 root，返回树中任意两节点的差的最小值。



示例：

输入: root = [4,2,6,1,3,null,null]
输出: 1
解释:
注意，root是树结点对象(TreeNode object)，而不是数组。

给定的树 [4,2,6,1,3,null,null] 可表示为下图:

          4
        /   \
      2      6
     / \
    1   3  

最小的差值是 1, 它是节点1和节点2的差值, 也是节点3和节点2的差值。


注意：

二叉树的大小范围在 2 到 100。
二叉树总是有效的，每个节点的值都是整数，且不重复。
本题与 530：https://leetcode-cn.com/problems/minimum-absolute-difference-in-bst/ 相同
```

## A

在二叉搜索树中寻找任意两节点的差最小的值。

### Sol 1. 遍历BST，将节点值放进数组，然后进行排序

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def minDiffInBST(self, root: TreeNode) -> int:
        L = []
        def help(node):
            if node != None:
                L.append(node.val)
                help(node.left)
                help(node.right)
        help(root)
        L.sort()
        min_ = 2**31
        for i in range(len(L)-1):
            diff = abs(L[i] - L[i+1])
            if diff < min_:
                min_ = diff
        return min_
```

### Sol 2. 递归 Recursion

已知树为BST，根据BST的特征：**左子节点的值<当前节点的值<右子节点的值**。

使用递归的方法进行中序遍历，将当前节点与上一轮节点取差值，与全局最小差值比较。

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def __init__(self):
        self.min_ = 2**31
        self.last = None
    def minDiffInBST(self, root: TreeNode) -> int:
        if root == None:
            return 0
        self.minDiffInBST(root.left)

        if self.last is not None:
            self.min_ = min(abs(root.val - self.last.val), self.min_)
        self.last = root

        self.minDiffInBST(root.right)
        return self.min_
```
