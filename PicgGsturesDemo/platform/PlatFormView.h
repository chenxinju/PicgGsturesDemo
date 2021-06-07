//
//  PlatFormView.h
//  PicgGsturesDemo
//
//  Created by 加一保 on 2020/12/25.
//

#import <UIKit/UIKit.h>
#import "GMImageContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlatFormView : UIView
@property UIView*coverContaienrView;
@property GMImageContainerView*coverImageView;
@property UILabel*nameLabel;
@property UILabel*dateLabel;
@property UIView*dateLine;
@property UIImageView*watermarkImageView;
@property UILabel*contentLabel;
@property UIImageView*avatarImageView;
@property UILabel*whiteDayLabel;
@property UILabel*blackDayLabel;

@property(nonatomic,strong) UIImage *coverImage; //外部设置图片 内容默认有本地图

@property(nonatomic,copy) NSString * coverImageUrlstr; //网络图片链接 选择了才有

@property NSInteger platfrom;//0 1,2,3,4...

-(void)updatePlatform:(NSInteger)platform;

-(CGFloat)platformViewHeight;
@end

NS_ASSUME_NONNULL_END
