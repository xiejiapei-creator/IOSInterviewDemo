//
//  ViewController.m
//  HHOTestProject
//
//  Created by xiejiapei on 2022/2/22.
//

#import "ViewController.h"
#import "fishhook.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    struct rebinding nslogbind;
    nslogbind.name = "NSLog";
    nslogbind.replacement = newmethod;
    nslogbind.replaced = (void*)&old_nslog;
    struct rebinding rebinds[] = {nslogbind};
    rebind_symbols(rebinds, 1);
}

static void (*old_nslog)(NSString *format,...);

void newmethod(NSString *format,...) {
    va_list va;
    va_start(va, format);
    // 改变下字符串，证明hook过了
    format = [format stringByAppendingString:@" hook"];
    old_nslog(format,va);
    va_end(va);
}

@end
