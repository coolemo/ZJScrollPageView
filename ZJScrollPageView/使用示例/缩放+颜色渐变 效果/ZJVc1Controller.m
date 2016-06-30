//
//  ZJVc2Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc1Controller.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"
#import "ZJTest1Controller.h"
@interface ZJVc1Controller ()<ZJScrollPageViewDelegate>
@property(weak, nonatomic)ZJScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation ZJVc1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;
    style.segmentViewBounces = NO;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 显示附加的按钮
    style.showExtraButton = YES;
    // 设置附加按钮的背景图片
    style.extraBtnBackgroundImageName = @"extraBtnBackgroundImage";
    
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球",
                    @"汽车",
                    @"囧途旅游",
                    @"幽默搞笑",
                    @"视频",
                    @"无厘头",
                    @"美女图片",
                    @"今日房价",
                    @"头像",
                    ];
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:_titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    
    [self.scrollPageView setSelectedIndex:1 animated:true];
    
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    [self.view addSubview:self.scrollPageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma <#arguments#>
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    // 根据不同的下标或者title返回相应的控制器, 但是控制器必须要遵守ZJScrollPageViewChildVcDelegate
    // 并且可以通过实现协议中的方法来加载不同的数据
    // 注意ZJScrollPageView不会保证viewWillAppear等生命周期方法一定会调用
    // 所以建议使用ZJScrollPageViewChildVcDelegate中的方法来加载不同的数据
    
    if (index == 0) {
        // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
        // 请首先判断返回给你的是否是可重用的
        // 如果为nil就重新创建并返回
        // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
        ZJTestViewController *childVc = (ZJTestViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTestViewController alloc] init];
            childVc.view.backgroundColor = [UIColor yellowColor];
        }
        return childVc;
        
    } else if (index == 1) {
        ZJTestViewController *childVc = (ZJTestViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTestViewController alloc] init];
            childVc.view.backgroundColor = [UIColor redColor];
        }
        return childVc;
    } else {
        ZJTest1Controller *childVc = (ZJTest1Controller *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTest1Controller alloc] init];
            childVc.view.backgroundColor = [UIColor greenColor];
        }
        
        if (index%2==0) {
            childVc.view.backgroundColor = [UIColor orangeColor];
        }
        
        return childVc;
    }
}




- (void)dealloc
{
//        NSLog(@"%@-----test", self.description);

}


@end
