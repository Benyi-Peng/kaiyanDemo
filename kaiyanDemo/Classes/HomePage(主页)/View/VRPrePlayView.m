//
//  VRPrePlayView.m
//  kaiyanDemo
//
//  Created by pbyi on 16/10/11.
//  Copyright © 2016年 wethinkvr. All rights reserved.
//

#import "VRPrePlayView.h"
#import "VRHomeCell.h"
#import "VRContentView.h"
#import "VRDetailScrollView.h"

#import "EveryDayModel.h"

#import "UIImageView+WebCache.h"
#import "Masonry.h"

@implementation VRPrePlayView

- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSArray *)models index:(NSInteger)index majorScrollDelegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
        
        EveryDayModel *model = models[index];
        
        //0.介绍文字
        VRContentView *contentView = [[VRContentView alloc] initWithFrame:CGRectMake(0, kHeight / 1.7 + 64, kWidth, kHeight - kHeight / 1.7 - 64) model:model];
        [self addSubview:contentView];
        _contentView = contentView;
        contentView.backgroundColor = [UIColor clearColor];
        
        //1.cell
        VRHomeCell *animateCell = [[VRHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _animateCell = animateCell;
        [_animateCell.coverview removeFromSuperview];
        [self addSubview:_animateCell];
        
        //2.详情大图片
        VRDetailScrollView *majorScrollView = [[VRDetailScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight / 1.7) models:models index:index];
        [self addSubview:majorScrollView];
        _majorScrollView = majorScrollView;
        _majorScrollView.delegate = delegate;
        _majorScrollView.alpha = 0;
        
        //3.播放
        UIImageView *playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/2-50, kHeight / 1.7 / 2 - 50 + 64, 100, 100)];
        [playImageView setImage:[UIImage imageNamed:@"video-play"]];
        [self addSubview:playImageView];
        _playImageView = playImageView;
        _playImageView.alpha = 0;
    }
    return self;
}

- (void)show {
    self.contentView.frame = CGRectMake(0, self.offsetY, kWidth, 250);
    self.animateCell.frame = CGRectMake(0, self.offsetY, kWidth, 250);
    self.animateCell.picture.transform = self.animationTrans;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.animateCell.frame = CGRectMake(0, 64, kWidth, kHeight/1.7);
        self.animateCell.picture.transform = CGAffineTransformMakeTranslation(0, (kHeight/1.7 - 250 - 30)/2);
        self.contentView.frame = CGRectMake(0, kHeight/1.7 + 64, kWidth, kHeight - kHeight/1.7 - 64);
    } completion:^(BOOL finished) {
        _majorScrollView.alpha = 1;
        [UIView animateWithDuration:0.25 animations:^{
            _playImageView.alpha = 1;
            _animateCell.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)dismissPrePlayView {
    [UIView animateWithDuration:0.25 animations:^{
        _playImageView.alpha = 0;
        _animateCell.alpha = 1;
    } completion:^(BOOL finished) {
        _majorScrollView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.contentView.frame = CGRectMake(0, self.offsetY, kWidth, 250);
            self.animateCell.frame = CGRectMake(0, self.offsetY, kWidth, 250);
            self.animateCell.picture.transform = self.animationTrans;
        } completion:^(BOOL finished) {
            [_contentView removeFromSuperview];
            [UIView animateWithDuration:0.25 animations:^{
                _animateCell.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }];
}

- (void)dealloc {
    NSLog(@"prePlayView dealloc");
}

@end
