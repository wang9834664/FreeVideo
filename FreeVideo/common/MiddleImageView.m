//
//  MiddleImageView.m
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import "MiddleImageView.h"
#import "Constants.h"
#import "UIImageView+AFNetworking.h"

@interface MiddleImageView ()

@end

@implementation MiddleImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMG_WIDTH, IMG_HEIGHT)];
        self.imageView.image = LOADING_IMG;
        [self addSubview:self.imageView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, IMG_HEIGHT, IMG_WIDTH, 20)];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.label];
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
