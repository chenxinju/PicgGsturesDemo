//
//  WFMAlert.h
//  FMPhoneShell
//
//  Created by iOS1 on 2020/8/25.
//  Copyright © 2020 FMCompany. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WFMAlert;
/*
 block 回调 alert本身 index 左0  右1
 
 */
typedef void (^DLHAlertBlock)(WFMAlert *_Nullable alert,NSInteger index);


@interface WFMAlert : UIView

/*
 WFMAlert *alert =  [[WFMAlert alloc] initWithTitle:@"确定删除吗？" leftBtnString:@"取消" contentString:nil rightBtnString:@"确定" handler:nil];
 [alert show];
 */


/**
 * 创建DLHAlert对象
 *
 * @param title                  标题
 * @param topimgString           顶部图片 传nil 不显示
 * @param leftBtnString          左边按钮文本
 * @param contentString          提示文本
 * @param rightBtnString         右边按钮文本
 * @param alertBlock             block回调
 *
 * @return LPActionSheet对象
 */


- (instancetype __nullable)initWithTitle:(NSString *_Nullable)title
                topimgString:(NSString  *_Nullable)topimgString
            leftBtnString:(NSString *_Nullable)leftBtnString
            contentString:(NSString *_Nullable)contentString
            rightBtnString:(NSString *_Nullable)rightBtnString
handler:(DLHAlertBlock _Nullable )alertBlock NS_DESIGNATED_INITIALIZER;
- (void)show;
/**
 * 收起视图
 */
- (void)dismiss;
@end
