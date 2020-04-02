# 1137 第 N 个泰波那契数 tribonacci

Tag: 递归/dp，数组

## Q

```
泰波那契序列 Tn 定义如下：

T0 = 0, T1 = 1, T2 = 1, 且在 n >= 0 的条件下 Tn+3 = Tn + Tn+1 + Tn+2

给你整数 n，请返回第 n 个泰波那契数 Tn 的值。



示例 1：

输入：n = 4
输出：4
解释：
T_3 = 0 + 1 + 1 = 2
T_4 = 1 + 1 + 2 = 4
示例 2：

输入：n = 25
输出：1389537


提示：

0 <= n <= 37
答案保证是一个 32 位整数，即 answer <= 2^31 - 1。
```

## A

在二叉搜索树中寻找大于L及小于R的节点值的和。

已知树为BST，根据BST的特征：**左子节点的值<当前节点的值<右子节点的值**。

## 递归 Recursion

使用递归，记录初始条件，从顶向下递归。

```py
class Solution:
    def tribonacci(self, n: int) -> int:
        if n == 0:
            return 0
        if n == 1:
            return 1
        if n == 2:
            return 1
        return self.tribonacci(n-1) + self.tribonacci(n-2) + self.tribonacci(n-3)
```

结果超时，用Dict优化：

好处：对于重复的子问题不需要重复计算

## 递归优化

```py
class Solution:
    def __init__(self):
        self.Dict = {}
    def tribonacci(self, n: int) -> int:
        if n == 0:
            return 0
        if n == 1:
            return 1
        if n == 2:
            return 1

        if n in self.Dict:
            return self.Dict[n]

        self.Dict[n] = self.tribonacci(n-1) + self.tribonacci(n-2) + self.tribonacci(n-3)
        return self.Dict[n]
```

## 自底向上动态规划 Dynamic Programming

先解决简单问题，得到局部解，在网上递推得出全局解。

当前位置值为前三个值的和，需要创建三个变量在遍历时保存前三个值。

```py
class Solution:
    def tribonacci(self, n: int) -> int:
        if n == 0:
            return 0
        if n == 1:
            return 1
        if n == 2:
            return 1

        T0 = 0
        T1 = 1
        T2 = 1
        cur = 0
        for i in range(2, n):
            cur = T0+T1+T2
            T0 = T1
            T1 = T2
            T2 = cur
        return cur
```
