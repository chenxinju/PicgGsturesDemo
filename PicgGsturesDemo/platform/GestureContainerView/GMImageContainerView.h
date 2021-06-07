//
//  GMImageContainerView.h
//  GoodMorningSayings
//
//  Created by iOS1 on 2020/12/23.
//  Copyright © 2020 CXJ-2021. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGestureManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface GMImageContainerView : UIView

@property(nonatomic,strong) UIImage * image;
@property(nonatomic,copy) NSString * imageUrlstr;
@property(nonatomic,strong,nullable) void(^singleTapBlock)(GMImageContainerView * imageContainerView);
// 编辑变化block，用户的任何引起变化的编辑动作都会调用此block
@property(nonatomic,copy) void(^editChangesBlock)(GMImageContainerView * imageContainerView);

- (void)setImage:(UIImage *)image reloadLayout:(BOOL)reloadLayout;

- (void)setImageUrl:(NSString *)imageurl reloadLayout:(BOOL)reloadLayout;

- (void)beginImageContext;
- (UIImage *)getCropImage;
- (UIImage *)getCropImageWithNewImageContent:(UIImage *)newImage;
- (void)endImageContext;

@end

NS_ASSUME_NONNULL_END
