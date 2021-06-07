//
//  WFMAlert.m
//  FMPhoneShell
//
//  Created by iOS1 on 2020/8/25.
//  Copyright © 2020 FMCompany. All rights reserved.
//


#import "WFMAlert.h"

@interface WFMAlert()
/** block回调 */
@property (copy, nonatomic) DLHAlertBlock alertBlock;

@property(nonatomic,strong) UIImageView * toplogoImageView;
/** 背景图片 */
@property (strong, nonatomic) UIView *backgroundView;
/** 弹出视图 */
@property (strong, nonatomic) UIView *alertView;

@property(nonatomic,assign) CGFloat alertWidth;

@property(nonatomic,strong) UIButton * leftBtn;
@property(nonatomic,strong) UIButton * rightBtn;

@property(nonatomic,strong) UIView * leftBtnBgView;
@property(nonatomic,strong) UIView * rightBtnBgView;

@end


@implementation WFMAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithTitle:nil topimgString:nil leftBtnString:nil contentString:nil rightBtnString:nil handler:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithTitle:nil topimgString:nil leftBtnString:nil contentString:nil rightBtnString:nil handler:nil];
}

-(instancetype)initWithTitle:(NSString *)title topimgString:(NSString *)topimgString leftBtnString:(NSString *)leftBtnString contentString:(NSString *)contentString rightBtnString:(NSString *)rightBtnString handler:(DLHAlertBlock)alertBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.alertWidth = 278.f;
        
        if ([UIScreen mainScreen].bounds.size.width == 320) { // iPhoneSE
            
            
            
        }else if ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 667) { // iPhone6
            
            self.alertWidth = 285.f;
            
        }else if ([UIScreen mainScreen].bounds.size.width == 414 && [UIScreen mainScreen].bounds.size.height == 736) { // iPhone6s Plus
            
            self.alertWidth = 300.f;
            
        }else if (iPhoneX) { // All iPhoneX
            
            //            if ([UIScreen mainScreen].bounds.size.height == 896) { // iPhoneXs Max
            
            self.alertWidth = 300.f;
            //            }
        }
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _alertBlock = alertBlock;
        // 默认高度
        CGFloat alertHeight = 30.f;
        
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        [self addSubview:_backgroundView];
        
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(self.alertWidth / 2, 0, self.alertWidth, 0)];
        _alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 4.0f;
        _alertView.layer.masksToBounds = YES;
        [self addSubview:_alertView];
        
        if (topimgString) {
            _toplogoImageView = [[UIImageView alloc]init];
            if (topimgString.length <= 2) {
                _toplogoImageView.image = [UIImage imageNamed:@"alert_top"];
            }else {
                _toplogoImageView.image = [UIImage imageNamed:topimgString];
            }
            [_toplogoImageView sizeToFit];
            [self addSubview:_toplogoImageView];
        }
        
        
        // 标题
        UILabel *titleLabel;
        if (title.length > 0 && title != nil) {
            
            CGSize size = [title boundingRectWithSize:CGSizeMake(self.alertWidth - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, alertHeight, self.alertWidth - 50, ceil(size.height))];
            titleLabel.text = title;
            titleLabel.textColor = [self colorFromHexRGB:@"#000000"];
            titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
            titleLabel.numberOfLines = 0;
            //titleLabel.backgroundColor = [UIColor grayColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [_alertView addSubview:titleLabel];
            
            alertHeight = CGRectGetMaxY(titleLabel.frame) + 15;
            
        }
        // 内容
        if (contentString.length > 0 && contentString != nil) {
            
            CGSize size = [contentString boundingRectWithSize:CGSizeMake(self.alertWidth - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, alertHeight, self.alertWidth - 50, ceil(size.height))];
            
            contentLabel.text = contentString;
            contentLabel.textColor = [self colorFromHexRGB:@"#888888"];
            contentLabel.font = [UIFont systemFontOfSize:17.0f];
            contentLabel.numberOfLines = 0;
            //contentLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
            contentLabel.textAlignment = NSTextAlignmentCenter;
            [_alertView addSubview:contentLabel];
            
            alertHeight = CGRectGetMaxY(contentLabel.frame) + 25;
            
            
        }else{
            if (titleLabel) {
                CGRect frame = titleLabel.frame;
                frame.origin.y = 30.f;
                CGFloat bottom = 25.f;
                if ([UIScreen mainScreen].bounds.size.width == 320) { // iPhoneSE
                    
                    
                }else if ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 667) { // iPhone6
                    
                    frame.origin.y = 35.f;
                    bottom = 30.f;
                    
                }else if ([UIScreen mainScreen].bounds.size.width == 414 && [UIScreen mainScreen].bounds.size.height == 736) { // iPhone6s Plus
                    frame.origin.y = 38.f;
                    bottom = 35.f;
                    
                }else if (iPhoneX) { // All iPhoneX
                    
                    //                    if ([UIScreen mainScreen].bounds.size.height == 896) { // iPhoneXs Max
                    
                    frame.origin.y = 38.f;
                    bottom = 35.f;
                    //                    }
                }
                
                titleLabel.frame = frame;
                alertHeight = CGRectGetMaxY(titleLabel.frame) + bottom;
            }
        }
        
        
        
        
        // 按钮上面的线条
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, alertHeight, self.alertWidth, 0.5)];
        line.backgroundColor = [self colorFromHexRGB:@"#E0DEE1"];
        [_alertView addSubview:line];
        // 左按钮
        if (leftBtnString.length > 0 && leftBtnString != nil) {
            // 有 右侧按钮 即两个按钮的情况
            if (rightBtnString.length > 0 && rightBtnString != nil) {
                // 左侧按钮
                UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, alertHeight, self.alertWidth/2, 50)];
                [leftBtn setTitle:leftBtnString forState:UIControlStateNormal];
                if ([leftBtnString isEqualToString:@"取消"] || [leftBtnString hasPrefix:@" "]) {
                    [leftBtn setTitleColor:[self colorFromHexRGB:@"#000000"] forState:UIControlStateNormal];
                }else{
                    [leftBtn setTitleColor:[self colorFromHexRGB:@"#B8B8B8"] forState:UIControlStateNormal]; //576B95
                }
                
                leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
                leftBtn.tag = 0;
                [leftBtn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [leftBtn addTarget:self action:@selector(alertBtnClickedDown:) forControlEvents:UIControlEventTouchDown];
                [leftBtn addTarget:self action:@selector(alertBtnClickedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
                [_alertView addSubview:leftBtn];
                self.leftBtn = leftBtn;
                
                // 按钮背景
                UIView * leftBtnBgView = [[UIView alloc] initWithFrame:leftBtn.frame];
                [_alertView insertSubview:leftBtnBgView belowSubview:leftBtn];
                self.leftBtnBgView = leftBtnBgView;
                
                // 右侧按钮
                UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.alertWidth/2, alertHeight, self.alertWidth/2, 50)];
                [rightBtn setTitle:rightBtnString forState:UIControlStateNormal];
                [rightBtn setTitleColor:[self colorFromHexRGB:@"#101010"] forState:UIControlStateNormal]; //576B95
                rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
                rightBtn.tag = 1;
                [rightBtn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [rightBtn addTarget:self action:@selector(alertBtnClickedDown:) forControlEvents:UIControlEventTouchDown];
                [rightBtn addTarget:self action:@selector(alertBtnClickedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
                [_alertView addSubview:rightBtn];
                self.rightBtn = rightBtn;
                
                // 按钮背景
                UIView * rightBtnBgView = [[UIView alloc] initWithFrame:rightBtn.frame];
                [_alertView insertSubview:rightBtnBgView belowSubview:rightBtn];
                self.rightBtnBgView = rightBtnBgView;
                
                // 按钮上面的线条
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame), alertHeight + 0.5, 0.5, leftBtn.frame.size.height - 0.5)];
                line.backgroundColor = [self colorFromHexRGB:@"#E0DEE1"];
                [_alertView addSubview:line];
                
            }else{
                // 一个按钮的情况
                UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, alertHeight, self.alertWidth, 50)];
                [leftBtn setTitle:leftBtnString forState:UIControlStateNormal];
                [leftBtn setTitleColor:[self colorFromHexRGB:@"#101010"] forState:UIControlStateNormal]; //#576B95
                leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
                leftBtn.tag = 0;
                [leftBtn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_alertView addSubview:leftBtn];
                [leftBtn addTarget:self action:@selector(alertBtnClickedDown:) forControlEvents:UIControlEventTouchDown];
                [leftBtn addTarget:self action:@selector(alertBtnClickedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
                [_alertView addSubview:leftBtn];
                self.leftBtn = leftBtn;
                
                // 按钮背景
                UIView * leftBtnBgView = [[UIView alloc] initWithFrame:leftBtn.frame];
                [_alertView insertSubview:leftBtnBgView belowSubview:leftBtn];
                self.leftBtnBgView = leftBtnBgView;
            }
            
            alertHeight += 50;
        }
        _alertView.frame = CGRectMake(self.alertWidth/2, 0, self.alertWidth, alertHeight);
        _alertView.center = self.center;
        
        _toplogoImageView.centerX = _alertView.centerX;
        _toplogoImageView.bottomY = _alertView.topY + 37;
    }
    
    return self;
}

- (void)alertBtnClicked:(UIButton *)btn{
    
    if (self.alertBlock) {
        self.alertBlock(self, btn.tag);
    }
    [self alertBtnClickedUpOutside:btn];
    [self dismiss];
}

- (void)alertBtnClickedDown:(UIButton *)btn{
    
    UIColor * selectedColor = [UIColor colorWithRed:0.8627 green:0.8510 blue:0.8627 alpha:1.f];
    
    if (btn.tag == 0) { // 左按钮
        
        if (self.leftBtnBgView) {
            [UIView animateWithDuration:0.1f animations:^{
                self.leftBtnBgView.backgroundColor = selectedColor;
            }];
        }
        
    }else{ // 右按钮
        
        if (self.rightBtnBgView) {
            [UIView animateWithDuration:0.1f animations:^{
                self.rightBtnBgView.backgroundColor = selectedColor;
            }];
        }
    }
}

- (void)alertBtnClickedUpOutside:(UIButton *)btn{
    
    if (btn.tag == 0) { // 左按钮
        
        if (self.leftBtnBgView) {
            [UIView animateWithDuration:0.1f animations:^{
                self.leftBtnBgView.backgroundColor = [UIColor clearColor];
            }];
        }
        
    }else{
        
        if (self.rightBtnBgView) {
            [UIView animateWithDuration:0.1f animations:^{
                self.rightBtnBgView.backgroundColor = [UIColor clearColor];
            }];
        }
    }
    
}

- (void)show
{
    // 在主线程中处理,否则在viewDidLoad方法中直接调用,会先加本视图,后加控制器的视图到UIWindow上,导致本视图无法显示出来,这样处理后便会优先加控制器的视图到UIWindow上
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
        if (self.alertView) {
            
            self.alertView.alpha = 0.0f;
            self.backgroundView.alpha = 0.0f;
            [UIView animateWithDuration:0.25f animations:^{
                self.alertView.alpha = 1.f;
                self.backgroundView.alpha = 1.f;
            }];
        }
        
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc{
    
    NSLog(@"DLHAlert dealloc");
}

#pragma mark - 字体颜色
/*!
 * @method 通过16进制计算颜色
 * @result 颜色对象
 */
- (UIColor *)colorFromHexRGB:(NSString *)inColorString{
    
    NSString *cString = [[inColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if (cString.length < 6)
    {
        return [UIColor blackColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length != 6)
    {
        return [UIColor blackColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //   OutLog(@"r=%f,g=%f,b=%f",(float)r,(float)g,(float)b);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
