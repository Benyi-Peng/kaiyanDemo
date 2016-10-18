//
//  VRContentView.h
//  kaiyanDemo
//
//  Created by pbyi on 16/10/14.
//  Copyright © 2016年 wethinkvr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EveryDayModel;
@interface VRContentView : UIView

@property (strong, nonatomic) EveryDayModel *model;
- (void)setModel:(EveryDayModel *)model;
- (instancetype)initWithFrame:(CGRect)frame model:(EveryDayModel *)model;
@end
