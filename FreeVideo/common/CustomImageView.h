//
//  CustomImageView.h
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIImageView+AFNetworking.h"

@interface CustomImageView : UIView

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

- (void)setImgWithURL:(NSURL *)url;

- (void)setImgWithURL:(NSURL *)url
     placeholderImage:(UIImage *)placeholderImage;

- (void)setTitle:(NSString *)title;

@end
