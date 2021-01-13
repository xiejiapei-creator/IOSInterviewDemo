//
//  ListViewController.m
//  Arithmetic
//
//  Created by 谢佳培 on 2020/10/23.
//

#import "ListViewController.h"

// 定义一个链表节点
struct Node
{
    // 节点数据1 2 3 4
    int data;
    // 指针，指向下一个节点
    struct Node *next;
};

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self test_reverseList];
}

#pragma mark - 链表反转

- (void)test_reverseList
{
    struct Node* head = constructList();
    printList(head);
    printf("-----------\n");
    struct Node* newHead = reverseList(head);
    printList(newHead);
}

// 入参是原来链表的头节点，返回值是新的列表的头节点
struct Node* reverseList(struct Node *head)
{
    // 定义遍历指针，初始化为原来链表的头结点
    struct Node *p = head;
    // 反转后的链表头部的指针
    struct Node *newH = NULL;
    
    // 遍历链表,p指针为空，该链表就遍历完成了
    while (p != NULL) {
        
        // 记录下一个结点
        struct Node *temp = p->next;
        // 当前结点的next指向新链表头部
        p->next = newH;
        // 更改新链表头部为当前结点
        newH = p;
        // 移动p指针
        p = temp;
    }
    
    // 返回反转后的链表头结点
    return newH;
}

// 构建新链表
struct Node* constructList(void)
{
    // 头结点定义
    struct Node *head = NULL;
    // 记录当前尾结点
    struct Node *cur = NULL;
    
    for (int i = 1; i < 5; i++) {
        struct Node *node = malloc(sizeof(struct Node));
        node->data = i;
        
        // 头结点为空，新结点即为头结点
        if (head == NULL) {
            head = node;
        }
        // 当前结点的next为新结点
        else{
            cur->next = node;
        }
        
        // 设置当前结点为新结点
        cur = node;
    }
    
    return head;
}

// 打印链表
void printList(struct Node *head)
{
    struct Node* temp = head;
    while (temp != NULL)
    {
        printf("node is %d \n", temp->data);
        temp = temp->next;
    }
}


@end
