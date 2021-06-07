//
//  ViewController.m
//  PicgGsturesDemo
//
//  Created by 加一保 on 2020/11/26.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>
#import "PlatFormView.h"
#import "DayTagViewController.h"
#import "GMImageContainerView.h"
@interface ViewController ()
@property WKWebView*webview;
@property NSTimer*timer;
@property PlatFormView*platformView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _platformView = [[PlatFormView alloc] init];
//    [self.view addSubview:self.platformView];
//    [self.platformView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).mas_offset(16);
//        make.right.equalTo(self.view).mas_offset(-16);
//        make.top.equalTo(self.view).mas_offset(16);
//        make.height.mas_equalTo(400);
//    }];
//    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
//
    [self performSelector:@selector(a) withObject:nil afterDelay:1];
//    GMImageContainerView*view = [[GMImageContainerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
//
//    [self.view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(200);
//    }];
//    view.image = [UIImage imageNamed:@"image_pic"];
    
    
  
   
    
}
-(void)a{
//    [UIView animateWithDuration:0.33 animations:^{
//        [self.platformView updatePlatform:0];
//        [self.view layoutIfNeeded];
//    }];
    DayTagViewController*vc = [[DayTagViewController alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:true  completion:nil];
}
-(void)PicgGsturesDemo{
    NSLog(@"sleep_before");
    for (int i = 0; i<1000; i++) {
        
    }
    NSLog(@"sleep_end");
}
- (IBAction)end:(id)sender {
    [self.timer invalidate];
    self.timer  = nil;
}
- (IBAction)start:(id)sender {
    [self end:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(PicgGsturesDemo) userInfo:nil repeats:true];
}

@end
