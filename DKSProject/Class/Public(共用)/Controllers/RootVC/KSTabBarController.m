//
//  KSTabBarController.m
//  DKSProject
//
//  Created by aDu on 2018/3/13.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "KSTabBarController.h"
#import "KSHomeController.h"
#import "KSDemoController.h"
#import "KSMessageController.h"
#import "KSMineController.h"

@interface KSTabBarController ()

@property (nonatomic, strong) NSMutableArray *vcAry;

@end

@implementation KSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self changeTabBarLineColor];
    [self setTabBra];
}

- (void)setTabBra {
    KSHomeController *homeVC = [[KSHomeController alloc] init];
    [self setViewController:homeVC titleStr:@"首页" imageStr:@"bar_home"];
    
    KSDemoController *demoVC = [[KSDemoController alloc] init];
    [self setViewController:demoVC titleStr:@"汇总" imageStr:@"bar_demo"];
    
    KSMessageController *msgVC = [[KSMessageController alloc] init];
    [self setViewController:msgVC titleStr:@"消息" imageStr:@"bar_msg"];
    
    KSMineController *mineVC = [[KSMineController alloc] init];
    [self setViewController:mineVC titleStr:@"我" imageStr:@"bar_mine"];
    
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor ks_mainColor];
    self.viewControllers = self.vcAry.copy;
}

/**
 tablebar，图形在上面，文字在下面

 @param viewController <#viewController description#>
 @param titleStr <#titleStr description#>
 @param imageStr <#imageStr description#>
 */
- (void)setViewController:(UIViewController *)viewController
                 titleStr:(NSString *)titleStr
                 imageStr:(NSString *)imageStr {
    viewController.title = titleStr;//文字
    viewController.tabBarItem.image = [UIImage imageNamed:imageStr];//图片
    //为文字设置属性
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor ks_backColor], NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor ks_mainColor], NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    KSNavigationController *nav = [[KSNavigationController alloc] initWithRootViewController:viewController];
    [self.vcAry addObject:nav];
}

#pragma mark - 改变TabBar分割线的颜色
- (void)changeTabBarLineColor {
    CGRect rect = CGRectMake(0, 0, Screen_Width, 1);
    UIGraphicsBeginImageContext(rect.size);//创建位图使成为上下文
    CGContextRef context = UIGraphicsGetCurrentContext();//返回图形上下文
    CGContextSetFillColorWithColor(context, [UIColor ks_backgroundColor].CGColor);//上下文的填充颜色
    CGContextFillRect(context, rect);//进行填充
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();//基于图像内容返回图像
    UIGraphicsEndImageContext();//从堆栈顶部删除基于位图的图形上下文
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
}

#pragma mark ====== init ======
- (NSMutableArray *)vcAry {
    if (!_vcAry) {
        _vcAry = [NSMutableArray array];
    }
    return _vcAry;
}

@end
