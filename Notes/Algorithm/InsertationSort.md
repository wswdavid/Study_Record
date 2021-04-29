# 插入排序
每次都将当前元素插入到左侧已经排序的数组中，使得插入之后左侧数组依然有序

对于数组 {3, 5, 2, 4, 1}，它具有以下逆序：(3, 2), (3, 1), (5, 2), (5, 4), (5, 1), (2, 1), (4, 1)，插入排序每次只能交换相邻元素，令逆序数量减少 1，因此插入排序需要交换的次数为逆序数量。

插入排序的时间复杂度取决于数组的初始顺序，如果数组已经部分有序了，那么逆序较少，需要的交换次数也就较少，时间复杂度较低。

* 平均情况下插入排序需要 ~N2/4 比较以及 ~N2/4 次交换；
* 最坏的情况下需要 ~N2/2 比较以及 ~N2/2 次交换，最坏的情况是数组是倒序的；
* 最好的情况下需要 N-1 次比较和 0 次交换，最好的情况就是数组已经有序了。

# 工具类
```java
public abstract class Sort<T extends Comparable<T>> {

    public abstract void sort(T[] nums);

    protected boolean isLess(T v, T w){
        return v.compareTo(w) < 0;
    }

    protected boolean isGreater(T v, T w){
        return v.compareTo(w) > 0;
    }

    protected void swap(T[] a, int i, int j) {
        T t = a[i];
        a[i] = a[j];
        a[j] = t;
    }

}
```

# 排序方法
```java
public void sort(T[] nums) {
        int N = nums.length;
        for (int i = 1; i < N; i++) {
            for (int j = i; j > 0 && isLess(nums[j], nums[j - 1]); j--) {
                swap(nums, j, j - 1);
            }
        }
        System.out.println(Arrays.toString(nums));
    }
```

# 总结
时间复杂度：O(N)~O(N^2^)
空间复杂度：1