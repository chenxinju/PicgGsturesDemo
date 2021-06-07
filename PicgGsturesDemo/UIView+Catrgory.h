//
//  UIView+Catrgory.h
//  GoodMorningSayings
//
//  Created by CoDancer on 16/12/14.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Catrgory)

///-------------------------------
/// Metric properties
///-------------------------------

@property (nonatomic, assign) CGFloat leftX;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat rightX;

@property (nonatomic, assign) CGFloat topY;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat bottomY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

/// 设置圆角
/// @param bounds       view 的 frame
/// @param cornerRadii  圆角半径 例如：CGSizeMake(15, 15)
/// @param rectCorner   圆角的方向 例如：UIRectCornerTopLeft | UIRectCornerTopRight
- (void)setCorners:(CGRect)bounds cornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)rectCorner;


- (UIImage *)captureImage;


//获取当前屏幕显示的viewcontroller
- (UIViewController *)currentlydisplayedVC;


/** 根据nib文件转UIView对象 */
+ (instancetype)getNibView:(NSString *)nibName;

@end
