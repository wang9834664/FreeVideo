//
//  DetailViewController.h
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *originData;

@property (nonatomic, strong) UIImageView *bigThumbnailImgView;
@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
@property (nonatomic, strong) UIView *infoScrView;
@property (nonatomic, strong) UIScrollView *videoDetailScrView;
@property (nonatomic, strong) UIScrollView *relativeScrView;


@end
