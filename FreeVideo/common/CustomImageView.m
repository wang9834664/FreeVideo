//
//  CustomImageView.m
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImgWithURL:(NSURL *)url
{
    [self.imageView setImageWithURL:url];
}

- (void)setImgWithURL:(NSURL *)url
     placeholderImage:(UIImage *)placeholderImage
{
    [self.imageView setImageWithURL:url placeholderImage:placeholderImage];
}

- (void)setTitle:(NSString *)title{
    self.label.text = title;
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
