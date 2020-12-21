//
//  SelectMenuView.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//



#import "SelectMenuView.h"

@interface selectMenuCell : UITableViewCell
/// 标题
@property (nonatomic, strong) UILabel *titLabel;
/// 选中图标
@property (nonatomic, strong) UIImageView *selectImageView;
/// 显示内容
@property (nonatomic, strong) NSString *cellDataSource;
/// UI配置
@property (nonatomic, strong) SelectMenuViewUIConfiguration *cellConfiguration;
/// table 宽度
@property (nonatomic, assign) CGFloat tableViewCellWidth;
@end

@interface selectMenuCell ()
@end

@implementation selectMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {\
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titLabel];
        [self.contentView addSubview:self.selectImageView];


    }
    return self;
}
- (void)setCellConfiguration:(SelectMenuViewUIConfiguration *)cellConfiguration {
    _cellConfiguration = cellConfiguration;
    self.titLabel.frame = CGRectMake(5, self.contentView.center.y - self.cellConfiguration.tableTitleFont / 2 , self.contentView.frame.size.width - 5 * 3 - 12 , self.cellConfiguration.tableTitleFont != 0 ? self.cellConfiguration.tableTitleFont : 13);
    self.selectImageView.frame = CGRectMake(self.titLabel.frame.size.width + self.titLabel.frame.origin.x + 5, self.contentView.center.y -  12 / 2 , 12, 12);

}
- (void)setCellDataSource:(NSString *)cellDataSource {
    self.titLabel.text = cellDataSource;
    self.titLabel.frame = CGRectMake(5, self.contentView.center.y - self.cellConfiguration.tableTitleFont / 2 , self.contentView.frame.size.width - 5 * 3 - 12 , self.cellConfiguration.tableTitleFont != 0 ? self.cellConfiguration.tableTitleFont : 13);
    self.selectImageView.frame = CGRectMake(self.titLabel.frame.size.width + self.titLabel.frame.origin.x + 5, self.contentView.center.y -  12 / 2 , 12, 12);



}

- (CGFloat)getWidthWithText:(NSString *)text Width:(CGFloat)width height:(CGFloat)height font:(CGFloat)font
{
    //内容宽度自适应
    CGSize size = CGSizeMake(width, height);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    if (height == 0) {
        return rect.size.height;
    }else {
        return rect.size.width;
    }
}
- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc]init];
        _titLabel.numberOfLines = 0;
        _titLabel.frame = CGRectMake(5, 5, 0, 0);
        _titLabel.font = [UIFont systemFontOfSize:self.cellConfiguration.tableTitleFont != 0 ? self.cellConfiguration.tableTitleFont : 13];
        _titLabel.textColor = self.cellConfiguration.tableTitleColor ? self.cellConfiguration.tableTitleColor : [UIColor blackColor];
        [_titLabel sizeToFit];
        
    }
    return _titLabel;;
}
- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]init];
        _selectImageView.bounds = CGRectMake(0, 0, 20, 20);
        _selectImageView.image = [UIImage imageNamed:@"select_icon"];
    }
    return _selectImageView;
}
@end

#define smv_Width [[UIScreen mainScreen] bounds].size.width
#define smv_height [[UIScreen mainScreen] bounds].size.height


@interface SelectMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, assign) SelectMenuViewArrowType type;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) SelectMenuViewUIConfiguration *configuration;
@property (nonatomic, strong) SelectMenuViewDataSourceConfiguration *dataSource;
@property (nonatomic, strong) NSArray * titleArray;


@end
@implementation SelectMenuView

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view arrowType:SelectMenuViewArrowTypeTopLeft];
}
- (instancetype)initWithView:(UIView *)view arrowType:(SelectMenuViewArrowType)type {
    self = [super init];
    if (self) {
        NSLog(@"%@",self.index);
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.f];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 5.0;
        self.layer.cornerRadius = 9.0;
        self.clipsToBounds = NO;
        [self setFrame:CGRectMake(0, 0, smv_Width, smv_height)];
        [self addView:view];
        
        self.type = type;
       
    }
    return self;
}
+ (instancetype)showMenuWithView:(UIView *)view {
    return [[self alloc]initWithView:view];
}
+ (instancetype)showMenuWithView:(UIView *)view arrowType:(SelectMenuViewArrowType)type {
    return [[self alloc]initWithView:view arrowType:type];
}
- (void)drawRect:(CGRect)rect {
    CGRect rects ;
    if (self.type == SelectMenuViewArrowTypeTopLeft) {
        rects =   CGRectMake(self.menuTableView.frame.origin.x + 6, self.menuTableView.frame.origin.y - 6,10 , 3);
    } else if (self.type == SelectMenuViewArrowTypeTopMiddle) {
        rects =   CGRectMake(self.menuTableView.frame.origin.x + self.menuTableView.frame.size.width / 2 - 10 / 2, self.menuTableView.frame.origin.y - 6,10 , 3);
    } else {
        rects =   CGRectMake(self.menuTableView.frame.origin.x + self.menuTableView.frame.size.width - 6 - 10 , self.menuTableView.frame.origin.y - 6,10 , 3);

    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, rects.origin.x + rects.size.width /2, rects.origin.y);
    CGContextAddLineToPoint(context,rects.origin.x, self.menuTableView.frame.origin.y);
    CGContextAddLineToPoint(context,rects.origin.x + rects.size.width, self.menuTableView.frame.origin.y);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [self.configuration.tableBackgroundColor setFill]; //设置填充色
    [self.configuration.tableBackgroundColor setStroke];//边框也设置为_color，否则为默认的黑色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

- (void)addView:(UIView *)view {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
    UIWindow *menuWindow = [[UIApplication sharedApplication].windows lastObject];
    [menuWindow addSubview:self];
       [self addSubview:self.menuTableView];
    CGRect rect=[view convertRect: view.bounds toView:menuWindow];
//    CGFloat tableViewWidth = self.dataSource.titleArray
    [self.menuTableView setFrame:CGRectMake(rect.origin.x , rect.origin.y +rect.size.height + 30.f, self.configuration.automaticWidth ?  rect.size.width : [self titleWidth], 0)];
    [UIView animateWithDuration:0.1 animations:^{
        [self.menuTableView setFrame:CGRectMake(rect.origin.x , rect.origin.y + rect.size.height + 30.f, self.configuration.automaticWidth ?  rect.size.width : [self titleWidth], self.configuration.totalHeight + 10)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            [self.menuTableView setFrame:CGRectMake(rect.origin.x , rect.origin.y + rect.size.height + 30.f, self.configuration.automaticWidth ?  rect.size.width : [self titleWidth], self.configuration.totalHeight)];
            if (self.delegate &&[self.delegate respondsToSelector:@selector(showSelectMenuView)]) {
                [self.delegate showSelectMenuView];
            }
        }];
    }];
        
    });

}

- (void)removeView {
    [UIView animateWithDuration:0.15 animations:^{
          [self.menuTableView setFrame:CGRectMake(self.menuTableView.frame.origin.x , self.menuTableView.frame.origin.y, self.menuTableView.frame.size.width, self.configuration.totalHeight + 10)];
      } completion:^(BOOL finished) {
          [UIView animateWithDuration:0.25 animations:^{
              [self.menuTableView setFrame:CGRectMake(self.menuTableView.frame.origin.x , self.menuTableView.frame.origin.y, self.menuTableView.frame.size.width, 0)];
          } completion:^(BOOL finished) {
              [self removeFromSuperview];
              if (self.delegate &&[self.delegate respondsToSelector:@selector(dismissSelectMenuView)]) {
                  [self.delegate dismissSelectMenuView];
              }
          }];
          
      }];
}

- (CGFloat)titleWidth {
    NSString *str = self.dataSource.titleArray[0];
    for (NSString *tit in self.dataSource.titleArray) {
        if (str.length < tit.length) {
            str = tit;
        }
    }
    
    return str.length * (self.configuration.tableTitleFont + 2) + 5 * 3 + 12;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.titleArray.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    selectMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([selectMenuCell class]) forIndexPath:indexPath];
    cell.cellConfiguration = self.configuration;
    cell.cellDataSource = self.dataSource.titleArray[indexPath.row];
    cell.backgroundColor = self.configuration.tableBackgroundColor;
    cell.titLabel.textColor = self.configuration.tableTitleColor;
    cell.titLabel.textAlignment = NSTextAlignmentLeft;
    cell.selectImageView.hidden = self.dataSource.indexRow == indexPath.row ? NO : YES;
  
    return cell;
  
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.configuration.cellHeight;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickCompletion) {
        self.clickCompletion(self.dataSource.titleArray[indexPath.row],indexPath.row);
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(clickWithCellTitle:indexPathRow:)]) {
           [self.delegate clickWithCellTitle:self.dataSource.titleArray[indexPath.row] indexPathRow:indexPath.row];
       
    }
    [self removeView];
    
}

- (MenuDataSourceBlock)dataSourceConfiguration {
    if (!_dataSourceConfiguration) {
        __weak typeof(self) weakSelf = self;
         return ^(SelectMenuViewDataSourceConfiguration *dataSource){
             weakSelf.dataSource = dataSource;
             
             return weakSelf;
         };
    }
    return _dataSourceConfiguration;
}

- (MenuUIBlock)uiConfiguration {
    if (!_uiConfiguration) {
        __weak typeof(self) weakSelf = self;
        return ^(SelectMenuViewUIConfiguration *configuration){
            weakSelf.configuration = configuration;
            self.menuTableView.backgroundColor = configuration.tableBackgroundColor != nil ? configuration.tableBackgroundColor : [UIColor whiteColor];
            self.menuTableView.rowHeight = configuration.cellHeight != 0 ? configuration.cellHeight : 44.f;

            return weakSelf;
        };
    }
    return _uiConfiguration;
}

- (UITableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc]init];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.rowHeight = self.configuration.cellHeight != 0 ? self.configuration.cellHeight : 44.f;
        [_menuTableView registerClass:[selectMenuCell class] forCellReuseIdentifier:NSStringFromClass([selectMenuCell class])];
        _menuTableView.tableFooterView = [UIView new];
        _menuTableView.layer.cornerRadius = 2; //设置imageView的圆角
        _menuTableView.layer.masksToBounds = YES;
        _menuTableView.backgroundColor = self.configuration.tableBackgroundColor != nil ? self.configuration.tableBackgroundColor : [UIColor whiteColor];
        _menuTableView.tableFooterView = [UIView new];
        
        _menuTableView.scrollEnabled = self.configuration.scrollEnabled ;
        
    }
    return _menuTableView;
}

@end
