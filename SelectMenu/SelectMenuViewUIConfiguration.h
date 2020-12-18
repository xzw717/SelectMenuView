//
//  SelectMenuViewConfiguration.h
//  SelectMenuView
//
//  Created by Ethan on 2020/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectMenuViewUIConfiguration : NSObject
/// 行高
@property (nonatomic, assign) CGFloat   cellHeight;
/// 宽度
@property (nonatomic, assign) CGFloat   cellWidth;
/// 总高度
@property (nonatomic, assign) CGFloat totalHeight;
/// 背景颜色
@property (nonatomic, strong) UIColor   *tableBackgroundColor;
/// 字体颜色
@property (nonatomic, strong) UIColor   *tableTitleColor;
/// 字体大小
@property (nonatomic, assign) CGFloat   tableTitleFont;
/// 选中的图片
@property (nonatomic, strong) UIImage   *selectImage;
/// 透明程度
@property (nonatomic, assign) CGFloat   tableAlpha;

/// 是否启用视图滚动
@property (nonatomic, assign) BOOL      scrollEnabled;



@end

NS_ASSUME_NONNULL_END
