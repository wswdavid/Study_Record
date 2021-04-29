# 选择排序

从数组中选择最小元素，将它与数组的第一个元素交换位置。再从数组剩下的元素中选择出最小的元素，将它与数组的第二个元素交换位置。不断进行这样的操作，直到将整个数组排序。

选择排序需要 ~N2/2 次比较和 ~N 次交换，它的运行时间与输入无关，这个特点使得它对一个已经排序的数组也需要这么多的比较和交换操作。

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
            for(int i =0; i<Num-1;i++){
                int min = i;
                for(int j =i+1; j< Num; j++){
                    if(isLess(nums[j],nums[min])){
                        min = j;
                    }
                }
                swap(nums,i,min);
            }
            System.out.println(Arrays.toString(nums));
        }
}
```

# 总结
时间复杂度：O(N^2^)
空间复杂度：1