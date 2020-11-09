//
//  UIStatusBarManager+Tap.m
//  Building6
//
//  Created by edz on 2020/9/25.
//  Copyright © 2020 funlink-tech. All rights reserved.
//

#import "UIStatusBarManager+Tap.h"

@implementation UIStatusBarManager (Tap)
- (void)handleTapAction:(id)callback {
    // 仅当 iOS 13 以上系统，才去监听状态栏的点击事件，iOS 13 之前的，则在 appdelegate 中的 touchesBegan 捕获
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.building6.notification.statusBarTappedNotification"
                                                            object:nil];
    }
}
@end
