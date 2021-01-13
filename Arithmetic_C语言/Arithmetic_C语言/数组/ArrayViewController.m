//
//  ArrayViewController.m
//  Arithmetic
//
//  Created by 谢佳培 on 2020/10/23.
//

#import "ArrayViewController.h"

@interface ArrayViewController ()

@end

@implementation ArrayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self test_findMedian];
}

#pragma mark - 数组合并

- (void)test_mergeArray
{
    int a[5] = {1,4,6,7,9};
    int b[8] = {2,3,5,6,8,10,11,12};
    int result[13];
    
    mergeArray(a, 5, b, 8, result);
    printf("有序数组合并结果：");
    for (int i = 0; i < 13; i++) {
        printf("%d ",result[i]);
    }
    printf("\n");
}

// 有序数组合并
void mergeArray(int a[], int aLen, int b[], int bLen, int result[])
{
    int p = 0; // 遍历数组a的指针
    int q = 0; // 遍历数组b的指针
    int i = 0; // 记录当前存储位置
    
    // 任一数组没有到达边界则进行遍历
    while (p < aLen && q < bLen)
    {
        // 如果a数组对应位置的值小于b数组对应位置的值
        if (a[p] <= b[q])
        {
            // 存储a数组的值
            result[i] = a[p];
            // 移动a数组的遍历指针
            p++;
        }
        else
        {
            // 存储b数组的值
            result[i] = b[q];
            // 移动b数组的遍历指针
            q++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    
    // 如果a数组有剩余
    while (p < aLen)
    {
        // 将a数组剩余部分拼接到合并结果的后面
        result[i] = a[p++];
        i++;
    }
    
    // 如果b数组有剩余
    while (q < bLen)
    {
        // 将b数组剩余部分拼接到合并结果的后面
        result[i] = b[q++];
        i++;
    }
}

#pragma mark - 查找无序数组的中位数

- (void)test_findMedian
{
    int list[10] = {12,3,10,8,6,7,11,13,9,4};
    // 3 6 7 8 9 10 11 12 13
    //         ^
    int median = findMedian(list, 10);
    printf("中位数为：%d \n", median);
}

// 求一个无序数组的中位数
int findMedian(int a[], int aLen)
{
    // 高低两个关键点，高在最后一个
    int low = 0;
    int high = aLen - 1;
    
    // 中位数在n/2-1
    int mid = (aLen - 1) / 2;
    // 快排算法找到分治节点的位置
    int div = PartSort(a, low, high);
    
    while (div != mid)
    {
        if (mid < div)
        {
            //左半区间找
            div = PartSort(a, low, div - 1);
        }
        else
        {
            //右半区间找
            div = PartSort(a, div + 1, high);
        }
    }
    //找到了
    return a[mid];
}

// 入参为数组和高低关键字
int PartSort(int a[], int start, int end)
{
    // 修改名字作为局部变量
    int low = start;
    int high = end;
    
    //选取结尾元素作为关键字
    int key = a[end];
    
    while (low < high)
    {
        // 低侧指针小于key
        // 左边找比key大的值
        while (low < high && a[low] <= key)
        {
            ++low;
        }
        
        // 高侧指针大于key
        // 右边找比key小的值
        while (low < high && a[high] >= key)
        {
            --high;
        }
        
        if (low < high)
        {
            //找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    // 完成快排后，交换high和end的值
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    // low作为分治排序后的中点返回
    return low;
}


@end
