//
//  GMImageContainerView.m
//  GoodMorningSayings
//
//  Created by iOS1 on 2020/12/23.
//  Copyright © 2020 CXJ-2021. All rights reserved.
//

#import "GMImageContainerView.h"


@interface GMImageContainerView (){
    
    CGContextRef context;
}

@property(nonatomic,strong) UIView * rotationView;
@property(nonatomic,strong) UIView * frameView;
@property(nonatomic,strong) UIImageView * imageView;
@property(nonatomic,strong) GMGestureManager * rotationGestureManager;
@property(nonatomic,strong) GMGestureManager * gestureManager;
@property(nonatomic,strong,nullable) void(^singleTapBlockBackup)(GMImageContainerView * imageContainerView);
@property(nonatomic,assign) BOOL isFirstSetImage; // 是否为首次设置图片
@property(nonatomic,assign) CGFloat recordDegree;

@end

@implementation GMImageContainerView

- (instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        self.frame = frame;
    }
    return self;
}

- (void)commonInit{
    
    self.isFirstSetImage = YES;
    
    self.clipsToBounds = YES;
    self.rotationView = [[UIView alloc] init];
    [self addSubview:self.rotationView];
    
    self.frameView = [[UIView alloc] init];
    [self addSubview:self.frameView];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.frameView addSubview:self.imageView];
    
    // 移动，缩放两种手势
    self.rotationGestureManager = [[GMGestureManager alloc] initWuthTargetView:self.rotationView gestureType:XyGestureType_Rotation|XyGestureType_SingleTap];
    self.gestureManager = [[GMGestureManager alloc] initWuthTargetView:self.imageView gestureType:XyGestureType_Pinch|XyGestureType_Pan|XyGestureType_DoubleTap|XyGestureType_DoubleTapAmplification];
    // 调整frame
    [self adjustFrame];
    
    __weak typeof(self) weakSelf = self;
    
    [self.rotationGestureManager setRotateGestureBlock:^(UIRotationGestureRecognizer *rotationGesture, UIGestureRecognizerState state) {
        
        switch (state) {
            case UIGestureRecognizerStateBegan:{
                
            }break;
            case UIGestureRecognizerStateChanged:{
                
            }break;
            default:{
                if (weakSelf.editChangesBlock) {
                    weakSelf.editChangesBlock(weakSelf);
                }
            }break;
        }
        
        weakSelf.frameView.bounds = weakSelf.rotationView.frame;
        
//        NSInteger angle = [weakSelf getRadianDegreeFromTransform:weakSelf.frameView.transform];
//        CGFloat angleD = [weakSelf getRadianDegreeFromTransform:weakSelf.frameView.transform];
        
        weakSelf.frameView.transform = CGAffineTransformRotate(weakSelf.frameView.transform, rotationGesture.rotation);
        
//        weakSelf.recordDegree = angleD;
//        NSLog(@"rotation:%lf",[weakSelf getRadianDegreeFromTransform:weakSelf.frameView.transform]);
    }];
    
    [self.rotationGestureManager setTapBlock:^(BOOL isSingleTap, BOOL isDoubleTap, BOOL isAnimationStart, BOOL isAnimationCompletion) {
        
        if (isSingleTap) {
            if (weakSelf.singleTapBlock) {
                weakSelf.singleTapBlock(weakSelf);
            }
        }
    }];
    
    [self.gestureManager setScaleValueBlock:^(CGFloat scale, BOOL stop) {
        
        if (stop) {
            
            [UIView animateWithDuration:0.25f animations:^{
                
                CGRect fitFrame = [weakSelf fitFrame_originalSize:weakSelf.imageView.image.size baseSize:weakSelf.frameView.bounds.size isInternal:NO]; // 外填充
                
                if (fitFrame.size.width > weakSelf.imageView.frame.size.width) { // 让视图的大小不能小于外填充
                    weakSelf.imageView.frame = fitFrame;
                }
                // 调整frame
                [weakSelf adjustFrame];
            }];
        }
        //NSLog(@"scale:%lf",scale);
    }];
    
    [self.gestureManager setPanGestureBlock:^(UIPanGestureRecognizer *panGesture, UIGestureRecognizerState state) {
        
        if (weakSelf.singleTapBlockBackup == nil) {
            weakSelf.singleTapBlockBackup = weakSelf.singleTapBlock;
        }
        
        if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
            weakSelf.singleTapBlock = nil;
        }else{
            
            [UIView animateWithDuration:0.25f animations:^{
                // 调整frame
                [weakSelf adjustFrame];
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.singleTapBlock = weakSelf.singleTapBlockBackup;
                weakSelf.singleTapBlockBackup = nil;
            });
        }
    }];
}

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

// 通过transform获取弧度值
- (CGFloat)getRadianDegreeFromTransform:(CGAffineTransform)transform{
    
    CGFloat rotate = acosf(transform.a);// 旋转180度后，需要处理弧度的变化
    if (transform.b < 0) {
        rotate = M_PI*2 - rotate;
    }
    return RADIANS_TO_DEGREES(rotate);
}


#pragma mark - 调整frame

- (void)adjustFrame{
    
    CGRect frame = self.imageView.frame;
    CGRect superFrame =  self.frameView.bounds;
    
    frame.origin.x = MIN(superFrame.origin.x, frame.origin.x);
    frame.origin.y = MIN(superFrame.origin.y, frame.origin.y);
    
    BOOL needUpdate = NO;
    
    CGFloat minLeftX = superFrame.size.width - frame.size.width + superFrame.origin.x;
    CGFloat minLeftY = superFrame.size.height - frame.size.height + superFrame.origin.y;
    if (frame.origin.y < minLeftY) {
        frame.origin.y = minLeftY;
        needUpdate = YES;
    }
    if (frame.origin.x < minLeftX) {
        frame.origin.x = minLeftX;
        needUpdate = YES;
    }
    
    if (CGSizeEqualToSize(self.imageView.image.size, CGSizeZero) == NO) {
        CGRect fitFrame = [self fitFrame_originalSize:self.imageView.image.size baseSize:self.frameView.bounds.size isInternal:NO]; // 外填充
        if (fitFrame.size.width > self.imageView.frame.size.width) { // 让视图的大小小于外填充则中心对齐
            self.imageView.center = CGPointMake(superFrame.size.width*0.5f, superFrame.size.height*0.5f);
            needUpdate = YES;
        }
    }
    
    self.imageView.frame = frame;
    
    if (self.editChangesBlock) {
        self.editChangesBlock(self);
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.rotationView.frame = self.bounds;
    self.frameView.frame = self.bounds;
    if (_image) {
        [self setImage:_image reloadLayout:YES];
    }
}

- (void)setImage:(UIImage *)image{
    
    if (_image != image) {
        _image = image;
    }
    [self setImage:image reloadLayout:YES];
}

- (void)setImage:(UIImage *)image reloadLayout:(BOOL)reloadLayout{
    
    if (_image != image) {
        _image = image;
    }
    
    if (image) {
        
        self.imageView.image = image;
        
        if (reloadLayout) {
            self.imageView.transform = CGAffineTransformIdentity;
            self.frameView.transform = CGAffineTransformIdentity;
            self.frameView.bounds = self.bounds;
            self.rotationView.transform = CGAffineTransformIdentity;
            if (CGSizeEqualToSize(self.imageView.image.size, CGSizeZero) == NO) {
                self.imageView.frame = [self fitFrame_originalSize:self.imageView.image.size baseSize:self.frameView.bounds.size isInternal:NO]; // 外填充
            }
        }
        
        if (self.isFirstSetImage == YES) {
            self.isFirstSetImage = NO;
            if (self.editChangesBlock) {
                self.editChangesBlock(self);
            }
        }
    }
}

- (void)setImageUrlstr:(NSString *)imageUrlstr {
    _imageUrlstr = imageUrlstr;
    
  [self setImageUrl:imageUrlstr reloadLayout:YES];
    
}

- (void)setImageUrl:(NSString *)imageurl reloadLayout:(BOOL)reloadLayout {
    
    if (imageurl) {
        
        __weak typeof(self) weakSelf = self;
        //SDWebImageHighPriority  高优先级下载
        //SDWebImageProgressiveLoad  渐进式下载
        //SDWebImageRetryFailed  图像下载失败后，仍旧继续尝试下载
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder_templet"] options:SDWebImageHighPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weakSelf.imageView.image = image;
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{ //需拿到图片后再处理填充问题
                    
                    if (reloadLayout) {
                        self.imageView.transform = CGAffineTransformIdentity;
                        self.frameView.transform = CGAffineTransformIdentity;
                        self.frameView.bounds = self.bounds;
                        self.rotationView.transform = CGAffineTransformIdentity;
                        if (CGSizeEqualToSize(self.imageView.image.size, CGSizeZero) == NO) {
                            
                            CGRect newRect = [self fitFrame_originalSize:self.imageView.image.size baseSize:self.frameView.bounds.size isInternal:NO];
                            //NSLog(@"newRect---%@",NSStringFromCGRect(newRect));
                            self.imageView.frame =  newRect;// 外填充
                        }
                    }else {
                        self.frameView.bounds = self.bounds;
                        // 调整frame
                        [self adjustFrame];
                    }
                    
                    if (self.isFirstSetImage == YES) {
                        self.isFirstSetImage = NO;
                        if (self.editChangesBlock) {
                            self.editChangesBlock(self);
                        }
                    }
                });
            }
            
        }];
    }
}

- (UIImage *)getCropImage{
    
    return [self snapshotImageFromView:self];
}
- (UIImage *)getCropImageWithNewImageContent:(UIImage *)newImage{
    
    self.imageView.image = newImage;
    return [self snapshotImageFromView:self];
}

- (void)beginImageContext{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 1.f);
    context = UIGraphicsGetCurrentContext();
}

// 高清屏幕截图
- (UIImage*)snapshotImageFromView:(UIView*)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (void)endImageContext{
    
    if (context) {
        CGContextRelease(context);
    }
}

// return 适合的内填充或外填充frame（此frame是居中的）
- (CGRect)fitFrame_originalSize:(CGSize)originalSize // 要转换的size
                       baseSize:(CGSize)baseSize     // 父容器size
                     isInternal:(BOOL)isInternal{    // 是否为内填充
    
    CGFloat fitWidth = 0;
    CGFloat fitHeight = 0;
    
    BOOL ratio = baseSize.height/baseSize.width >= originalSize.height/originalSize.width;
    
    if (isInternal == NO) {
        ratio = !ratio;
    }
    
    if (ratio) { // 适合宽度填充
        fitWidth = baseSize.width;
        fitHeight = (baseSize.width/originalSize.width)*originalSize.height;
    }else{ // 适合高度填充
        fitHeight = baseSize.height;
        fitWidth = (baseSize.height/originalSize.height)*originalSize.width;
    }
    //NSLog(@"fitWidth--%.2f fitHeight---%.2f baseSize--%@  originalSize---%@",fitWidth,fitHeight,NSStringFromCGSize(baseSize),NSStringFromCGSize(originalSize));
    return CGRectMake((baseSize.width-fitWidth)*0.5f, (baseSize.height-fitHeight)*0.5f,fitWidth, fitHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
