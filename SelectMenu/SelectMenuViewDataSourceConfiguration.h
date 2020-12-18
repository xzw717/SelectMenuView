//
//  SelectMenuViewDataSourceConfiguration.h
//  SelectMenuView
//
//  Created by Ethan on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectMenuViewDataSourceConfiguration : NSObject
/// 标题数组
@property (nonatomic, strong) NSArray *titleArray;
/// 设置初始选中 或 记录上次点击 不设置就是默认的第一行
@property (nonatomic, assign) NSInteger indexRow;

@end

NS_ASSUME_NONNULL_END
