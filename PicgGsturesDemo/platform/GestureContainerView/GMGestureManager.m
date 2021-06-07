//
//  GMGestureManager.m
//  GoodMorningSayings
//
//  Created by iOS1 on 2020/12/23.
//  Copyright © 2020 CXJ-2021. All rights reserved.
//

#import "GMGestureManager.h"


@interface GMGestureManager ()<UIGestureRecognizerDelegate>;

@property(nonatomic,weak) UIRotationGestureRecognizer * rotationGestureRecognizer;
@property(nonatomic,weak) UIPinchGestureRecognizer * pinchGestureRecognizer;
@property(nonatomic,weak) UIPanGestureRecognizer * panGestureRecognizer;
@property(nonatomic,weak) UITapGestureRecognizer * doubleTapGesture;
@property(nonatomic,weak) UITapGestureRecognizer * singleTapGesture;
@property(nonatomic,weak) UITapGestureRecognizer * doubleTapAmplificationGesture;

@end

@implementation GMGestureManager

- (instancetype)init{
    
    if (self = [super init]) {
        self.responseTouchesNumber = 1;
        self.doubleTapAmplificationRatio = 2.f;
    }
    return self;
}

- (instancetype)initWuthTargetView:(UIView *)targetView gestureType:(XyGestureType)type{
    
    if (self = [super init]) {
        self.gestureType = type;
        self.responseTouchesNumber = 1;
        self.doubleTapAmplificationRatio = 2.f;
        self.targetView = targetView;
    }
    return self;
}

- (void)setTargetView:(UIView *)targetView{
    _targetView = targetView;
    [self addGestureRecognizerToView:_targetView.superview];
}

- (CGFloat)scaleValue{
    
    _scaleValue = self.targetView.frame.size.width/self.targetView.bounds.size.width;
    return _scaleValue;
}


// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view{
    
    if (self.gestureType & XyGestureType_Rotation) {
        // 旋转手势
        UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
        rotationGestureRecognizer.delegate = self;
        rotationGestureRecognizer.cancelsTouchesInView = NO;
        [view addGestureRecognizer:rotationGestureRecognizer];
        self.rotationGestureRecognizer = rotationGestureRecognizer;
    }
    
    if (self.gestureType & XyGestureType_Pinch) {
        // 缩放手势
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
        pinchGestureRecognizer.delegate = self;
        pinchGestureRecognizer.cancelsTouchesInView = NO;
        [view addGestureRecognizer:pinchGestureRecognizer];
        self.pinchGestureRecognizer = pinchGestureRecognizer;
    }
    
    if (self.gestureType & XyGestureType_Pan) {
        // 移动手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        panGestureRecognizer.delegate = self;
        panGestureRecognizer.cancelsTouchesInView = NO;
        [view addGestureRecognizer:panGestureRecognizer];
        self.panGestureRecognizer = panGestureRecognizer;
    }
    
    if (self.gestureType & XyGestureType_DoubleTap) {
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapGesture.cancelsTouchesInView = NO;
        doubleTapGesture.numberOfTapsRequired =2;
        doubleTapGesture.numberOfTouchesRequired =1;
        [view addGestureRecognizer:doubleTapGesture];
        self.doubleTapGesture = doubleTapGesture;
    }
    
    if (self.gestureType & XyGestureType_SingleTap) {
        
        UITapGestureRecognizer * singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapGesture.cancelsTouchesInView = NO;
        singleTapGesture.numberOfTapsRequired =1;
        [view addGestureRecognizer:singleTapGesture];
        self.singleTapGesture = singleTapGesture;
    }
    
    if (self.gestureType & XyGestureType_DoubleTapAmplification) {
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapGesture.cancelsTouchesInView = NO;
        doubleTapGesture.numberOfTapsRequired =2;
        doubleTapGesture.numberOfTouchesRequired =1;
        [view addGestureRecognizer:doubleTapGesture];
        self.doubleTapAmplificationGesture = doubleTapGesture;
    }
    
}

#pragma mark - 解决手势冲突

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return false;
}

#pragma mark - 处理旋转手势
- (void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    
    if (self.rotateGestureBlock) {
        self.rotateGestureBlock(rotationGestureRecognizer,rotationGestureRecognizer.state);
    }
    
    if (self.gestureType & XyGestureType_Rotation && rotationGestureRecognizer.numberOfTouches >= self.responseTouchesNumber) {
        
        UIView * view;
        if (self.operationView != nil) {
            view = self.operationView;
        }else{
            view = self.targetView;
        }
        if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
            [rotationGestureRecognizer setRotation:0];
        }else{
            self.scaleValue = view.frame.size.width/view.bounds.size.width;
            if (self.scaleValueBlock) {
                self.scaleValueBlock(self.scaleValue,YES);
            }
        }
    }
    
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateEnded || rotationGestureRecognizer.state == UIGestureRecognizerStateCancelled){
        if (self.scaleValueBlock) {
            self.scaleValueBlock(self.scaleValue,YES);
        }
    }
}

#pragma mark - 处理双击手势

-(void)handleDoubleTap:(UIGestureRecognizer *)sender{
    
    if (self.tapBlock) {
        self.tapBlock(NO,YES,NO,NO);
    }
    
    if (self.doubleTapAmplificationGesture) {

        if (self.tapBlock) {
            self.tapBlock(NO,YES,YES,NO);
        }
        
        if (CGAffineTransformEqualToTransform(self.targetView.transform, CGAffineTransformIdentity)) {
            
            CGPoint point = [sender locationInView:self.targetView];
            
            [UIView animateWithDuration:0.5 delay:0.f usingSpringWithDamping:3.0 initialSpringVelocity:4.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.targetView.layer.anchorPoint = CGPointMake(point.x/self.targetView.frame.size.width, point.y/self.targetView.frame.size.height);
                self.targetView.transform = CGAffineTransformScale(self.targetView.transform, self.doubleTapAmplificationRatio, self.doubleTapAmplificationRatio);
                self.scaleValue = self.doubleTapAmplificationRatio;
            } completion:^(BOOL finished) {
                if (self.tapBlock) {
                    self.tapBlock(NO,YES,NO,YES);
                }
            }];
            
        }else{
            
            [UIView animateWithDuration:0.5 delay:0.f usingSpringWithDamping:3.0 initialSpringVelocity:4.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.targetView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
                self.targetView.transform = CGAffineTransformIdentity;
                self.targetView.center = CGPointMake(self.targetView.superview.bounds.size.width*0.5, self.targetView.superview.bounds.size.height*0.5);
                self.scaleValue = 1.f;
            } completion:^(BOOL finished) {
                if (self.tapBlock) {
                    self.tapBlock(NO,YES,NO,YES);
                }
            }];
        }
    }
}

#pragma mark - 处理单击手势

-(void)handleSingleTap:(UIGestureRecognizer *)sender{
    
    if (self.tapBlock) {
        self.tapBlock(YES,NO,NO,NO);
    }
}


#pragma mark - 处理缩放手势

- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    
    if (self.gestureType & XyGestureType_Pinch && pinchGestureRecognizer.numberOfTouches >= self.responseTouchesNumber) {
        
        UIView * view;
        if (self.operationView != nil) {
            view = self.operationView;
        }else{
            view = self.targetView;
        }
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            
            CGPoint position = [pinchGestureRecognizer locationInView:view.superview];
            CGPoint anchorPoint = [view.superview convertPoint:position toView:view];
            
            if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
                // 将锚点与position设置到缩放点的位置
                view.layer.position = position;
                view.layer.anchorPoint = CGPointMake(anchorPoint.x/view.bounds.size.width, anchorPoint.y/view.bounds.size.height);
            }
            
            view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
            
            static CGAffineTransform minTransform;//图片的最小缩放大小
            static CGAffineTransform maxTransform;//图片的最大缩放大小
            
            self.scaleValue = view.frame.size.width/view.bounds.size.width;
            if (self.scaleValueBlock) {
                self.scaleValueBlock(self.scaleValue,NO);
            }
            
            if (view.frame.size.width <= 15.f) {
                
                view.transform = minTransform;
            }else{
                minTransform = view.transform;
            }
            
            if (view.frame.size.width >= [UIScreen mainScreen].bounds.size.width*6.f) {
                
                view.transform = maxTransform;
            }else{
                maxTransform = view.transform;
            }
            
            pinchGestureRecognizer.scale = 1;
        }
    }
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded || pinchGestureRecognizer.state == UIGestureRecognizerStateCancelled){
        if (self.scaleValueBlock) {
            self.scaleValueBlock(self.scaleValue,YES);
        }
    }
    
}

#pragma mark - 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    if (self.panGestureBlock) {
        self.panGestureBlock(panGestureRecognizer,panGestureRecognizer.state);
    }
    
    if (self.gestureType & XyGestureType_Pan && panGestureRecognizer.numberOfTouches >= self.responseTouchesNumber) {
        
        UIView * view;
        if (self.operationView != nil) {
            view = self.operationView;
        }else{
            view = self.targetView;
        }
        if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            
            CGPoint translation = [panGestureRecognizer translationInView:view.superview];
            [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
            
            [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        }else{
            if (view.bounds.size.width) {
                self.scaleValue = view.frame.size.width/view.bounds.size.width;
            }
        }
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded || panGestureRecognizer.state == UIGestureRecognizerStateCancelled){
        if (self.scaleValueBlock) {
            if (isnan(self.scaleValue) == NO) {
                self.scaleValueBlock(self.scaleValue,YES);
            }
        }
    }
}

@end
