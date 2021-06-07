//
//  WaterMarkPopViewController.m
//  PicgGsturesDemo
//
//  Created by  CXJ-2021 on 2020/12/26.
//

#import "WaterMarkPopViewController.h"
#import <STPopup.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface WaterMarkPopViewController ()
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UIButton *watermarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;

@end

@implementation WaterMarkPopViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(SCREEN_WIDTH, 120);
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _infoBtn.selected = _showInfo;
    _watermarkBtn.selected = _showWatermark;
    _dateBtn.selected = _showDate;
    self.popupController.backgroundView.userInteractionEnabled = true;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        [self.popupController dismiss];
    }];
    [self.popupController.backgroundView addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self.popupController dismiss];
}
-(void)callback{
    if (self.changeCallback) {
        self.changeCallback(false, @{@"info":@(_infoBtn.selected),@"watermark":@(_watermarkBtn.selected),@"date":@(_dateBtn.selected)});
    }
}
- (IBAction)userinfoBtnClick:(UIButton *)sender {
    sender.selected=!sender.selected;
    [self callback];
}
- (IBAction)watermarkBtnClick:(UIButton *)sender {
    sender.selected=!sender.selected;
    [self callback];
}
- (IBAction)dateBtnclick:(UIButton *)sender {
    sender.selected=!sender.selected;
    [self callback];
}


@end
