//
//  ViewController.m
//  SelectMenuView
//
//  Created by Ethan on 2020/12/17.
//

#import "ViewController.h"
#import "SelectMenu/SelectMenuView.h"
@interface ViewController ()
@property (nonatomic, assign) NSInteger viewCotrollerIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame =CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    self.viewCotrollerIndex = 2;
}

- (void)click:(UIButton *)b {
    SelectMenuViewUIConfiguration *configurations =  [[SelectMenuViewUIConfiguration alloc]init];
    configurations.tableBackgroundColor = [UIColor blackColor];
    configurations.tableTitleColor = [UIColor whiteColor];
    configurations.scrollEnabled = NO;
    configurations.cellHeight = 40.f;
    configurations.tableTitleFont = 12.f;
    configurations.cellWidth = 120.f;
    configurations.totalHeight = 120.f;
    configurations.automaticWidth = NO;
    SelectMenuViewDataSourceConfiguration * dataSource = [[SelectMenuViewDataSourceConfiguration alloc]init];
    dataSource.titleArray = @[@"全部订单",@"优选商家订单",@"其他订单"];
    dataSource.indexRow = self.viewCotrollerIndex;
    SelectMenuView * menu = [SelectMenuView showMenuWithView:b arrowType:SelectMenuViewArrowTypeTopRight];
    menu.uiConfiguration(configurations).dataSourceConfiguration(dataSource);
    __weak typeof(self) weakSelf = self;
    [menu setClickCompletion:^(NSString * _Nonnull str, NSInteger index) {
        __strong typeof(self) self = weakSelf;
        self.viewCotrollerIndex = index;
        [b setTitle:str forState:UIControlStateNormal];
    }];
}

@end
