//
//  GMGestureManager.h
//  GoodMorningSayings
//
//  Created by iOS1 on 2020/12/23.
//  Copyright © 2020 CXJ-2021. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, XyGestureType) {
    XyGestureType_None       = 0,     // 无
    XyGestureType_Rotation   = 1 << 0, // 旋转
    XyGestureType_Pan        = 1 << 1, // 移动
    XyGestureType_Pinch      = 1 << 2, // 缩放
    XyGestureType_DoubleTap  = 1 << 3, // 双击
    XyGestureType_SingleTap  = 1 << 4, // 单击
    XyGestureType_DoubleTapAmplification = 1 << 5, // 双击放大
};

@interface GMGestureManager : NSObject

@property(nonatomic,weak) UIView * targetView;
// 操作视图为nil的时候targetView即为操作视图，否则手势事件操作的是operationView而不是targetView
@property(nonatomic,weak) UIView * operationView;
@property(nonatomic,assign) XyGestureType gestureType;
@property(nonatomic,assign) NSInteger responseTouchesNumber; // 响应的触摸数
@property(nonatomic,assign) CGFloat doubleTapAmplificationRatio; // 双击放大倍数


@property(nonatomic,copy) void(^scaleValueBlock)(CGFloat scale,BOOL stop);
@property(nonatomic,assign) CGFloat scaleValue;

@property(nonatomic,copy) void(^panGestureBlock)(UIPanGestureRecognizer * panGesture , UIGestureRecognizerState state);
@property(nonatomic,copy) void(^rotateGestureBlock)(UIRotationGestureRecognizer * rotationGesture,UIGestureRecognizerState state);
@property(nonatomic,copy) void(^tapBlock)(BOOL isSingleTap , BOOL isDoubleTap,BOOL isAnimationStart,BOOL isAnimationCompletion);

- (instancetype)initWuthTargetView:(UIView *)targetView gestureType:(XyGestureType)type;

#pragma mark - 对外提供处理双击手势的操作方法，方便你要时手动模拟双击手势
-(void)handleDoubleTap:(UIGestureRecognizer *)sender;

@end

NS_ASSUME_NONNULL_END
