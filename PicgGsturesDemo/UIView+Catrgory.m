//
//  UIView+Catrgory.m
//  GoodMorningSayings
//
//  Created by CoDancer on 16/12/14.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "UIView+Catrgory.h"

@implementation UIView (Catrgory)

#pragma mark - Metric properties

- (CGFloat)leftX
{
    return self.frame.origin.x;
}
- (void)setLeftX:(CGFloat)leftX
{
    self.frame = CGRectMake(leftX, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)rightX
{
    return self.frame.origin.x + self.bounds.size.width;
}
- (void)setRightX:(CGFloat)rightX
{
    self.frame = CGRectMake(rightX-self.bounds.size.width, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}


- (CGFloat)topY
{
    return self.frame.origin.y;
}
- (void)setTopY:(CGFloat)topY
{
    self.frame = CGRectMake(self.frame.origin.x, topY, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)bottomY
{
    return self.frame.origin.y + self.bounds.size.height;
}
- (void)setBottomY:(CGFloat)bottomY
{
    self.frame = CGRectMake(self.frame.origin.x, bottomY-self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.bounds.size.height);
}

- (CGFloat)height
{
    return self.bounds.size.height;
}
- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, height);
}


- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGSize)size
{
    return self.bounds.size;
}
- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (void)setCorners:(CGRect)bounds cornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)rectCorner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:rectCorner
                                                     cornerRadii:cornerRadii];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
//[self.shareLabel gm_generateCorners:CGRectMake(0, 0, UI_SCREEN_WIDTH, 50) cornerRadii:CGSizeMake(8, 8) rectCorner:UIRectCornerTopLeft | UIRectCornerTopRight];
}


#pragma mark - Image content

- (UIImage *)captureImage
{ /*
   size : size是指绘图上下文的宽高，可以理解为要绘制图形的画布的大小
   opaque ： 是否透明，如果传YES，画布的背景色为黑色，NO的时候，画布背景色是白色
   scale：指的是绘制出来的图片的像素比，决定了绘图图片的清晰度，一般填0.0，默认屏幕缩放比
   */
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return getImage;
}




//获取当前屏幕显示的viewcontroller
- (UIViewController *)currentlydisplayedVC
{
    UIViewController *result = nil;
    
    // 获取默认的window
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    // 获取window的rootViewController
    result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}


+ (instancetype)getNibView:(NSString *)nibName {
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

@end
