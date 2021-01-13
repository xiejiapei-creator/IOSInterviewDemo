//
//  CharacterViewController.m
//  Arithmetic
//
//  Created by 谢佳培 on 2020/10/23.
//

#import "CharacterViewController.h"

@interface CharacterViewController ()

@end

@implementation CharacterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self test_findFirstChar];
}

#pragma mark - 字符串顺序

- (void)test_char_reverse
{
    char ch[] = "hello,world";
    char_reverse(ch);
    printf("反转字符串结果是：%s \n",ch);
}

// 字符串反转
void char_reverse(char* cha)
{
    // 指向第一个字符
    char* begin = cha;
    // 指向最后一个字符
    char* end = cha + strlen(cha) - 1;
    
    while (begin < end) {
        // 交换前后两个字符,同时移动指针
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}

#pragma mark - 字符串查找

- (void)test_findFirstChar
{
    char cha[] = "gabaccdeff";
    char fc = findFirstChar(cha);
    printf("查找到第一个只出现一次的字符：%c \n",fc);
}

// 查找第一个只出现一次的字符
char findFirstChar(char* cha)
{
    char result = '\0';// 空字符
    // 定义一个数组 用来存储各个字母出现次数
    int array[256];
    // 对数组进行初始化操作
    for (int i=0; i<256; i++) {
        array[i] =0;
    }
    // 定义一个指针 指向当前字符串头部
    char* p = cha;
    // 遍历每个字符
    while (*p != '\0') {
        // 在字母对应存储位置(*p), 进行出现次数+1操作, 之后将p指针向后移动一位
        array[*(p++)]++;
    }
    
    // 将P指针重新指向字符串头部
    p = cha;
    // 遍历每个字母的出现次数
    while (*p != '\0') {
        // 遇到第一个出现次数为1的字符，打印结果
        if (array[*p] == 1)
        {
            result = *p;
            break;
        }
        // 反之继续向后遍历
        p++;
    }
    
    return result;
}


@end
