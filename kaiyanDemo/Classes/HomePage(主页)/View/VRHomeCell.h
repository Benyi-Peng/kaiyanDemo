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


@property (nonatomic, strong) EveryDayModel *model;

- (CGFloat)cellOffset;
@end
