# 冒泡排序
从左到右不断交换相邻逆序的元素，在一轮的循环之后，可以让未排序的最大元素上浮到右侧。

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
public class Bubble<T extends Comparable<T>> extends Sort<T> {
    public void sort(T[] nums) {
            int Num = nums.length;
            for(int i=0; i<Num; i++){
                for(int j=i+1; j<Num; j++){
                    if(isGreater(nums[i],nums[j])){
                        swap(nums,i,j);
                    }
                }
            }
            System.out.println(Arrays.toString(nums));
    }
}
```

方法2：
在一轮循环中，如果没有发生交换，那么说明数组已经是有序的，此时可以直接退出。
```java
public class Bubble<T extends Comparable<T>> extends Sort<T> {

    public void sort(T[] nums) {
        int N = nums.length;
        boolean isSorted = false;
        for (int i = N - 1; i > 0 && !isSorted; i--) {
            isSorted = true;
            for (int j = 0; j < i; j++) {
                if (isLess(nums[j + 1], nums[j])) {
                    isSorted = false;
                    swap(nums, j, j + 1);
                }
            }
        }
    }
    
}

```

# 总结
时间复杂度：O(N^2^)
空间复杂度：1