//
//  DayTagViewController.m
//  PicgGsturesDemo
//
//  Created by  CXJ-2021 on 2020/12/26.
//



#import "DayTagViewController.h"
#import "PlatFormView.h"
#import <Masonry.h>
#import "WaterMarkPopViewController.h"
#import "PlatformPopViewController.h"
#import <STPopup.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import "WFMAlert.h"

@interface DayTagViewController ()<UIScrollViewDelegate>

@property PlatFormView*platformView;
@property NSInteger currentPlatform;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) TZImagePickerController *imagePickerVc;

@end

@implementation DayTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.delegate = self;
    _currentPlatform = 0;
    _platformView = [[PlatFormView alloc] init];
    _platformView.backgroundColor = [UIColor whiteColor];
    
    
    _platformView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    _platformView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    _platformView.layer.shadowOffset = CGSizeMake(0,5);
    _platformView.layer.shadowOpacity = 1;
    _platformView.layer.shadowRadius = 10;
    
    
    
    //test
    _platformView.contentLabel.text = @"_dateLabel.text = _dateLabel.text = _dateLabel.text = _dateLabel.text =  _dateLabel.text = _dateLabel.text = _dateLabel.text = _dateLabel.text =  _dateLabel.text = _dateLabel.text = _dateLabel.text = _dateLabel.text =  _dateLabel.text = _dateLabel.text = _dateLabel.text = _dateLabel.text =  _dateLabel.text = _dateLabel.text = _dateLabel.text = _dateLabel.text =  _dateLabel.text = _dateLabel.text = _dateLabel.text = _dateLabel.text =  _dateLabel.text = _dateLabel.text = _dateLabel.text = _dateLabel.text =  ";
    _platformView.nameLabel.text = @"name";
    _platformView.dateLabel.text = @"2020-10-10";
    _platformView.whiteDayLabel.text = @"23";
    _platformView.blackDayLabel.text = @"23";
    _platformView.coverImage = [UIImage imageNamed:@"image_pic"];
    _platformView.coverImageView.image =_platformView.coverImage;
    //test
    
    
    
    
    [self.containerView addSubview:self.platformView];
    [self.platformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).mas_offset(16);
        make.right.equalTo(self.containerView).mas_offset(-16);
        make.top.equalTo(self.containerView).mas_offset(24);
        make.height.mas_equalTo([self.platformView platformViewHeight]);
    }];
    self.containerViewHeight.constant = [self.platformView platformViewHeight]+80;
}

- (IBAction)platformBtnClick:(UIButton *)sender {
    PlatformPopViewController*vc =[[PlatformPopViewController alloc] init];
    @weakify(self);
    vc.changeCallback = ^(BOOL isError, NSDictionary *json) {
        @strongify(self);
        self.currentPlatform = [json[@"index"] integerValue];
        [self.platformView updatePlatform:self.currentPlatform];
        [self.platformView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([self.platformView platformViewHeight]);
        }];
        self.containerViewHeight.constant = [self.platformView platformViewHeight]+80;
    };
    vc.platform = _currentPlatform;
    STPopupController*pop = [[STPopupController alloc] initWithRootViewController:vc];
    pop.style = STPopupStyleBottomSheet;
    pop.navigationBarHidden = true;
    [pop presentInViewController:self];
}
- (IBAction)photoBtnClick:(UIButton *)sender {
    
        // 从相册中选取 imagePickerVc框架选择
        if ([self isPhotoLibraryAvailable]) {
    
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted ) {
    
                NSLog(@"----因为系统原因，无法访问相册");
    
            }else if (status == PHAuthorizationStatusDenied){
    
                
                WFMAlert *alert =   [[WFMAlert alloc]initWithTitle:@"提示" topimgString:nil leftBtnString:@"取消" contentString:@"支持相册使用需前往系统设置app相册访问" rightBtnString:@"去设置" handler:^(WFMAlert * _Nullable alert, NSInteger index) {
                    
                    if (index == 1) {
                        [self openURLWithString:UIApplicationOpenSettingsURLString];
                    }
                }];
                [alert show];
    
            }else {
    
                self.imagePickerVc.allowPickingVideo = NO;
                __weak typeof(self) weakSelf = self;
                [self.imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    if (photos.count) {
                        weakSelf.platformView.coverImage = photos.firstObject;
                    }
                }];
                [self presentViewController:self.imagePickerVc animated:YES completion:nil];
    
            }
    
        }
    
}

//图片库
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}


- (void)openURLWithString:(NSString *)url
{
    NSURL *appUrl = [NSURL URLWithString:url];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:appUrl options:@{UIApplicationOpenURLOptionsOpenInPlaceKey:@"1"} completionHandler:^(BOOL success) {
            if(!success) {
            }
        }];
    }
}
- (IBAction)watermarkClick:(UIButton *)sender {
    WaterMarkPopViewController*vc =[[WaterMarkPopViewController alloc] init];
    vc.showInfo = !_platformView.nameLabel.hidden;
    vc.showDate = !_platformView.dateLabel.hidden;
    vc.showWatermark = !_platformView.watermarkImageView.hidden;
    @weakify(self);
    vc.changeCallback = ^(BOOL isError, NSDictionary *json) {
        @strongify(self);
        BOOL showInfo =  [json[@"info"] boolValue];
        BOOL showWatermark =  [json[@"watermark"] boolValue];
        BOOL showDate =  [json[@"date"] boolValue];
        self.platformView.dateLabel.hidden = !showDate;
        self.platformView.watermarkImageView.hidden = !showWatermark;
        self.platformView.nameLabel.hidden = !showInfo;
    };
    STPopupController*pop = [[STPopupController alloc] initWithRootViewController:vc];
    pop.style = STPopupStyleBottomSheet;
    pop.navigationBarHidden = true;
    [pop presentInViewController:self];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {

    return NO;

}
#pragma mark - ScrollVIewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {}


- (TZImagePickerController *)imagePickerVc{
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        _imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        _imagePickerVc.showSelectBtn = YES;
    }
    return _imagePickerVc;
}
@end
