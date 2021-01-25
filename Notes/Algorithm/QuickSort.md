# 快速排序
快速排序通过一个切分元素将数组分为两个子数组，左子数组小于等于切分元素，右子数组大于等于切分元素，将这两个子数组排序也就将整个数组排序了。

e.g.
排序类
```java
public class Vehicle {
    private int price;

    private String name;

    public Vehicle(int price, String name) {
        this.price = price;
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

排序方法
```java
public ArrayList<Vehicle> quickSortMethod(ArrayList<Vehicle> list){
        if (list.size()<=1){
            return list;
        }
        ArrayList<Vehicle> sorted;
        ArrayList<Vehicle> lesser = new ArrayList<Vehicle>();
        ArrayList<Vehicle> greater = new ArrayList<Vehicle>();

        Vehicle pivot = list.get(list.size()-1); // Use last Vehicle as pivot

        for(int i=0; i<list.size()-1;i++){
            if(list.get(i).getPrice()<=pivot.getPrice()){
                lesser.add(list.get(i));
            }else {
                greater.add(list.get(i));
            }
        }
        lesser = quickSortMethod(lesser);
        greater = quickSortMethod(greater);

        lesser.add(pivot);
        lesser.addAll(greater);
        sorted = lesser;

        return sorted;
    }
```

# 总结
时间复杂度： O(nlogn)
空间复杂度： O(logn)
