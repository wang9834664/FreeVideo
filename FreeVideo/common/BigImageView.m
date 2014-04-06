//
//  BigImageView.m
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import "BigImageView.h"

@interface BigImageView ()

@end
@implementation BigImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
        self.imageView.image = LOADING_IMG;
        [self addSubview:self.imageView];
        
        UIView *markView = [[UIView alloc] initWithFrame:CGRectMake(0, BIG_IMG_HEIGHT - 20, BIG_IMG_WIDTH, 20)];
        [markView setBackgroundColor:[UIColor blackColor]];
        markView.alpha = 0.7f;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BIG_IMG_WIDTH, 20)];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:14];
        
        [markView addSubview:self.label];
        [self addSubview:markView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
