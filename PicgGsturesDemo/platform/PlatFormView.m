//
//  PlatFormView.m
//  PicgGsturesDemo
//
//  Created by 加一保 on 2020/12/25.
//

#import "PlatFormView.h"
#import <Masonry.h>
@implementation PlatFormView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.platfrom = 0;
        [self setupView];
    }
    return self;
}
-(void)setupView{
    _nameLabel = [UILabel new];
    _dateLabel = [UILabel new];
    _coverContaienrView = [UIView new];
    _coverImageView = [[GMImageContainerView alloc] initWithFrame:CGRectZero];
    _watermarkImageView = [UIImageView new];
    _contentLabel = [UILabel new];
    _avatarImageView = [UIImageView new];
    _dateLine = [UIView new];
    _whiteDayLabel = [UILabel new];
    _blackDayLabel = [UILabel new];
    _coverContaienrView.clipsToBounds = true;
    
    _whiteDayLabel.font = _blackDayLabel.font = [UIFont systemFontOfSize:64];
    _whiteDayLabel.textColor = [UIColor whiteColor];
    _blackDayLabel.font = [UIFont systemFontOfSize:64];
    _blackDayLabel.textColor = UIColorFromHex(0x2C2E2E);
    [_coverContaienrView addSubview:_whiteDayLabel];
    
    
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _watermarkImageView.image =[ UIImage imageNamed:@"image_logo"];
    _dateLine.backgroundColor = UIColorFromHex(0x207BD2);
    
    CALayer*avatarLayer =  [_avatarImageView layer];
    avatarLayer.cornerRadius = 25;
    avatarLayer.borderColor = [UIColor whiteColor].CGColor;
    avatarLayer.borderWidth = 4;
    avatarLayer.masksToBounds = true;
    
    [self addSubview:_blackDayLabel];
    [self addSubview:_nameLabel];
    [self addSubview:_dateLabel];
    [self addSubview:_coverContaienrView];
    [_coverContaienrView addSubview:_coverImageView];
    [self addSubview:_watermarkImageView];
    [self addSubview:_contentLabel];
    [self addSubview:_avatarImageView];
    [self addSubview:self.dateLine];
    [self addSubview:self.dateLabel];
    
    
    [_whiteDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(19);
        make.bottom.equalTo(self.coverContaienrView.mas_bottom).mas_offset(30);
    }];
    [_blackDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(19);
        make.bottom.equalTo(self.coverContaienrView.mas_bottom).mas_offset(30);
    }];
    
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = UIColorFromHex(0x2C2E2E);
    self.contentLabel.numberOfLines = 0;
    
    
    
    [self updatePlatform:2];
    [_watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_equalTo(14);
        make.bottom.equalTo(self.mas_bottom).mas_offset(-23);
    }];
    
    
}
-(void)updatePlatform:(NSInteger)platform{
    self.platfrom = platform;
    switch (platform) {
        case 0:
            [self platform0];
            break;
        case 1:
            [self platform1];
            break;
        case 2:
            [self platfrom2];
            break;
        case 3:
            [self platfrom3];
            break;
    }
}
-(void)platfrom3{
    _whiteDayLabel.hidden = _blackDayLabel.hidden = false;
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.textColor = UIColorFromHex(0x2C2E2E);
    _dateLine.hidden = true;
    _avatarImageView.hidden = true;
    _coverImageView.layer.cornerRadius = 0;
    _coverImageView.layer.masksToBounds = true;
    
    
    CGFloat selfWidth = SCREEN_WIDTH-32;
    [_coverContaienrView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(self.coverContaienrView.mas_width).multipliedBy(214.0/341.0);
    }];
    
    [_coverImageView removeFromSuperview];
    _coverImageView = nil;
    _coverImageView = [[GMImageContainerView alloc] initWithFrame:CGRectMake(0, 0,selfWidth, selfWidth*214.0/341.0)];
    [_coverImageView setImage:_coverImage reloadLayout:true];
    [self.coverContaienrView addSubview:_coverImageView];
//    [_coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.height.mas_equalTo(self.coverContaienrView);
//    }];
    
    
    [_dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(-16);
        make.top.equalTo(self.coverContaienrView.mas_bottom).mas_offset(8);
    }];
    
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(24);
        make.right.equalTo(self).mas_offset(-24);
        make.top.equalTo(self.coverContaienrView.mas_bottom).mas_offset(70);
    }];
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentLabel.mas_bottom).mas_offset(16);
    }];
    [self.coverContaienrView bringSubviewToFront:self.whiteDayLabel];
    
    
}
-(void)platfrom2{
    _whiteDayLabel.hidden = _blackDayLabel.hidden = true;
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.textColor = UIColorFromHex(0x2C2E2E);
    _dateLine.hidden = true;
    _coverImageView.layer.cornerRadius = 0;
    _coverImageView.layer.masksToBounds = true;
    _avatarImageView.hidden = false;
    
    _avatarImageView.image = [UIImage imageNamed:@"image_pic"];
    
    [_coverContaienrView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(self.coverContaienrView.mas_width).multipliedBy(214.0/341.0);
    }];
    
    [_coverImageView removeFromSuperview];
    _coverImageView = nil;
    CGFloat selfWidth = SCREEN_WIDTH-32;
    _coverImageView = [[GMImageContainerView alloc] initWithFrame:CGRectMake(0, 0,selfWidth, selfWidth*214.0/341.0)];
    [_coverImageView setImage:_coverImage reloadLayout:true];
    [self.coverContaienrView addSubview:_coverImageView];
//    [_coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.height.mas_equalTo(self.coverContaienrView);
//    }];
    
    [_avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.top.equalTo(self.coverContaienrView.mas_bottom).mas_offset(-15);
        make.left.equalTo(self).mas_offset(28);
    }];
    
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).mas_offset(4);
        make.top.equalTo(self.coverContaienrView.mas_bottom).mas_offset(8);
    }];
    
    [_dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(-16);
        make.top.equalTo(self.coverContaienrView.mas_bottom).mas_offset(8);
    }];
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(24);
        make.right.equalTo(self).mas_offset(-24);
        make.top.equalTo(self.coverContaienrView.mas_bottom).mas_offset(70);
    }];
    
    
}
-(void)platform1{
    
    _whiteDayLabel.hidden = _blackDayLabel.hidden = true;
    _avatarImageView.hidden = true;
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.textColor = UIColorFromHex(0x2C2E2E);
    _dateLine.hidden = true;
    
    CGFloat ratio =  204.0/375.0;
    CGFloat imageWidth =SCREEN_WIDTH*ratio;
    [_coverContaienrView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(imageWidth+80);
    }];
    
//    [_coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.coverContaienrView).mas_offset(40);
//        make.centerX.equalTo(self.coverContaienrView);
//        make.width.height.mas_equalTo(imageWidth);
//    }];
    
    
    [_coverImageView removeFromSuperview];
    _coverImageView = nil;
    
    CGFloat x =  ((SCREEN_WIDTH-32) - imageWidth)/2;
    _coverImageView = [[GMImageContainerView alloc] initWithFrame:CGRectMake(x, 40,imageWidth, imageWidth)];
    [_coverImageView setImage:_coverImage reloadLayout:true];
    _coverImageView.userInteractionEnabled = false;
    [self.coverContaienrView addSubview:_coverImageView];
    _coverImageView.layer.cornerRadius = imageWidth / 2;
    _coverImageView.layer.masksToBounds = true;
    
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(24);
        make.right.equalTo(self).mas_offset(-24);
        make.top.equalTo(self.coverContaienrView.mas_bottom);
    }];
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentLabel.mas_bottom).mas_offset(20);
    }];
    [_dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(4);
    }];
    
    
    
    
}
-(void)platform0{
    _whiteDayLabel.hidden = _blackDayLabel.hidden = true;
    _dateLine.hidden = false;
    _coverImageView.layer.cornerRadius = 0;
    _coverImageView.layer.masksToBounds = true;
    _avatarImageView.hidden = true;
    
    
    [_coverContaienrView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(self.coverContaienrView.mas_width).multipliedBy(214.0/341.0);
    }];
//    [_coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.height.mas_equalTo(self.coverContaienrView);
//    }];
    
    [_coverImageView removeFromSuperview];
    _coverImageView = nil;
    CGFloat selfWidth = SCREEN_WIDTH-32;
    _coverImageView = [[GMImageContainerView alloc] initWithFrame:CGRectMake(0, 0,selfWidth, selfWidth*214.0/341.0)];
    [_coverImageView setImage:_coverImage reloadLayout:true];
    [self.coverContaienrView addSubview:_coverImageView];
    [self.dateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.coverContaienrView);
        make.top.equalTo(self.coverContaienrView.mas_bottom);
        make.height.mas_equalTo(2);
    }];
    [_dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(115);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.dateLine.mas_bottom);
    }];
    
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(24);
        make.right.equalTo(self).mas_offset(-24);
        make.top.equalTo(self.dateLine).mas_offset(40);
    }];
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentLabel.mas_bottom).mas_offset(20);
    }];
    
    _dateLabel.backgroundColor = UIColorFromHex(0x207BD2);
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.textColor = [UIColor whiteColor];
    
    
    
}
-(CGFloat)heightWithSize:(CGSize)size str:(NSString*)str font:(UIFont*)font{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [str boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:font} context:nil].size.height;
    
}
-(CGFloat)platformViewHeight{
    switch (_platfrom) {
        case 0:
        {
            //高度
            CGFloat contentHeight = [self heightWithSize:CGSizeMake(SCREEN_WIDTH-32-48, CGFLOAT_MAX) str:self.contentLabel.text font:self.contentLabel.font];
            CGFloat totalHeight   = (SCREEN_WIDTH-32)*214.0/341.0+2+20+40+contentHeight+160;
            return totalHeight;
        }
        case 1:
        {
            //高度
            CGFloat ratio =  204.0/375.0;
            CGFloat imageWidth =SCREEN_WIDTH*ratio;
            CGFloat contentHeight = [self heightWithSize:CGSizeMake(SCREEN_WIDTH-32-48, CGFLOAT_MAX) str:self.contentLabel.text font:self.contentLabel.font];
            CGFloat totalHeight   = imageWidth+80+contentHeight+42+22+80;
            return totalHeight;
        }
        case 2:
        {
            //高度
            CGFloat contentHeight = [self heightWithSize:CGSizeMake(SCREEN_WIDTH-32-48, CGFLOAT_MAX) str:self.contentLabel.text font:self.contentLabel.font];
            //没标注 预估
            CGFloat totalHeight   = (SCREEN_WIDTH-32)*214.0/341.0+70+contentHeight+100;
            return totalHeight;
        }
        case 3:
        {
            //高度
            CGFloat contentHeight = [self heightWithSize:CGSizeMake(SCREEN_WIDTH-32-48, CGFLOAT_MAX) str:self.contentLabel.text font:self.contentLabel.font];
            //没标注 预估
            CGFloat totalHeight   = (SCREEN_WIDTH-32)*214.0/341.0+70+contentHeight+120;
            return totalHeight;
        }
        default:
            break;
    }
    
    return 0;
}

- (void)setCoverImage:(UIImage *)coverImage {
   
    if (_coverImage != coverImage) {
        _coverImage = coverImage;
    }
    if (_coverImage) {
        self.coverImageView.image = _coverImage;
    }
}

- (void)setCoverImageUrlstr:(NSString *)coverImageUrlstr {
    _coverImageUrlstr = coverImageUrlstr;
    
    if (coverImageUrlstr.length) { //使用第一张网络图
       self.coverImageView.imageUrlstr = coverImageUrlstr;
    }
}

@end
