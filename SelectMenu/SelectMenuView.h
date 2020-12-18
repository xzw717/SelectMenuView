//
//  SelectMenuView.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "SelectMenuViewUIConfiguration.h"
#import "SelectMenuViewDataSourceConfiguration.h"


@protocol SelectMenuViewDelegate <NSObject>

@optional
/// 点击的角色模型
//- (void)clickWithModel:(RoleListModel *_Nonnull)model;
/// 视图已经出现
- (void)showSelectMenuView;
/// 视图已经消失
- (void)dismissSelectMenuView;


@end
#import <UIKit/UIKit.h>

/// 箭头出现的方向
typedef NS_ENUM(NSInteger,SelectMenuViewArrowType) {
    SelectMenuViewArrowTypeTopLeft = 0,
    SelectMenuViewArrowTypeTopMiddle,
    SelectMenuViewArrowTypeTopRight
};

@class SelectMenuView;
typedef SelectMenuView *_Nonnull(^MenuDataSourceBlock)(SelectMenuViewDataSourceConfiguration * _Nonnull dataSource);
typedef SelectMenuView *_Nonnull(^MenuUIBlock)(SelectMenuViewUIConfiguration * _Nullable configuration);
typedef SelectMenuView *_Nonnull(^MenufromView)(UIView * _Nonnull view);
typedef void(^ClickTitle)(NSString * _Nonnull str);

NS_ASSUME_NONNULL_BEGIN

@interface SelectMenuView : UIView
/// 设置数据源
@property (nonatomic, copy) MenuDataSourceBlock dataSourceConfiguration;
/// 设置外观
@property (nonatomic, copy) MenuUIBlock uiConfiguration;

@property (nonatomic, copy) MenufromView clickView;
@property (nonatomic, copy) ClickTitle clickModel;
//@property (nonatomic, copy) MenuViewSelf dismissView;
@property (nonatomic, weak) id <SelectMenuViewDelegate>delegate;



- (instancetype)initWithView:(UIView *)view;
- (instancetype)initWithView:(UIView *)view arrowType:(SelectMenuViewArrowType)type;

+ (instancetype)showMenuWithView:(UIView *)view;
+ (instancetype)showMenuWithView:(UIView *)view arrowType:(SelectMenuViewArrowType)type;
@end

NS_ASSUME_NONNULL_END
