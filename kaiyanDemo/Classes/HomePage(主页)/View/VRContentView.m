//
//  VRContentView.m
//  kaiyanDemo
//
//  Created by pbyi on 16/10/14.
//  Copyright © 2016年 wethinkvr. All rights reserved.
//

#import "VRContentView.h"
#import "EveryDayModel.h"
#import "UIImageView+WebCache.h"

@interface VRContentView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *littleLabel;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UIView *lineView;
@property (weak, nonatomic) UIImageView *bgImageView;
@end

@implementation VRContentView
- (instancetype)initWithFrame:(CGRect)frame model:(EveryDayModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView = bgImageView;
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:bgImageView];
        
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurView.frame = self.bounds;
        [self addSubview:blurView];
        
        UIColor *color = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kWidth, 30)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = color;
        [self addSubview:_titleLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(5, 35, 200, 1)];
        _lineView.backgroundColor = color;
        [self addSubview:_lineView];
        
        _littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 46, kWidth, 20)];
        _littleLabel.textColor = color;
        _littleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_littleLabel];
        
        _descripLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 80, kWidth - 10, 90)];
        _descripLabel.font = [UIFont systemFontOfSize:14];
        _descripLabel.numberOfLines = 0;
        _descripLabel.textColor = color;
        [self addSubview:_descripLabel];
        
        [self setModel:model];
    }
    return self;
}

- (void)setModel:(EveryDayModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.descripLabel.text = model.descrip;
    
    NSInteger time = [model.duration integerValue];
    NSString *timeString = [NSString stringWithFormat:@"%02ld'%02ld''",time/60,time% 60];//显示的是音乐的总时间
    NSString *string = [NSString stringWithFormat:@"#%@ / %@",model.category, timeString];
    self.littleLabel.text = string;
    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
}

@end
