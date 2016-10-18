//
//  VRPrePlayView.h
//  kaiyanDemo
//
//  Created by pbyi on 16/10/11.
//  Copyright © 2016年 wethinkvr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VRHomeCell,VRContentView,VRDetailScrollView;

@interface VRPrePlayView : UIView
@property (weak, nonatomic) VRDetailScrollView *majorScrollView;            //封面图
@property (weak, nonatomic) UIImageView *playImageView;                     //播放
@property (weak, nonatomic) VRContentView *contentView;                     //描述内容视图
@property (weak, nonatomic) VRHomeCell *animateCell;                        //弱持有外界cell.(用于动画)

@property (assign, nonatomic) CGFloat offsetY;                              //记录动画开始时候的Y值
@property (assign, nonatomic) CGAffineTransform animationTrans;             //记录封面图片起始transform

- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSArray *)models index:(NSInteger)index majorScrollDelegate:(id)delegate;
- (void)show;
- (void)dismissPrePlayView;
@end
