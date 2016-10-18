//
//  VRHomeCell.h
//  kaiyanDemo
//
//  Created by pbyi on 16/10/11.
//  Copyright © 2016年 wethinkvr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EveryDayModel;
@interface VRHomeCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picture;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *littleLabel;

@property (nonatomic, strong) UIView *coverview;

@property (nonatomic, strong) EveryDayModel *model;

- (CGFloat)cellOffset;
@end
