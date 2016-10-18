//
//  VRDetailScrollView.m
//  kaiyanDemo
//
//  Created by pbyi on 16/10/14.
//  Copyright © 2016年 wethinkvr. All rights reserved.
//

#import "VRDetailScrollView.h"
#import "EveryDayModel.h"

#import "UIImageView+WebCache.h"

@implementation VRDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray *)models index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(models.count * kWidth, 0);
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(index*kWidth, 0);
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        for (NSInteger i = 0; i < models.count; i++) {
            EveryDayModel *model = models[i];
            UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(i*kWidth, 0, kWidth, kHeight/1.7)];
            picture.contentMode = UIViewContentModeScaleAspectFill;
            picture.clipsToBounds = YES;
            [picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
            [self addSubview:picture];
        }
    }
    return self;
}

@end
