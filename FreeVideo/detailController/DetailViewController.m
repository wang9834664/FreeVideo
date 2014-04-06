//
//  DetailViewController.m
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import "DetailViewController.h"
#import "Constants.h"
#import "UIImageView+AFNetworking.h"

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    NSLog(@"-------------------");
    NSLog(@"%@", self.originData);
    [self.navigationController.navigationBar setHidden:YES];
    
    //初始化大图
    self.bigThumbnailImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
    NSURL *image_url = [[NSURL alloc] initWithString:[self.originData objectForKey:@"bigThumbnail"]];
    [self.bigThumbnailImgView setImageWithURL:image_url placeholderImage: LOADING_IMG];
    [self.view addSubview:self.bigThumbnailImgView];
    
    //初始化segment控件
    [self initSegmentCtrl];
    //初始化信息
    [self initInfoScrollView];
    //初始化视频详情
    [self initVideoDetailScrView];
    //初始化相关视频或者剧集
    [self initRelativeScrollView];
    
    [self.infoScrView addSubview:self.segmentCtrl];
    [self.infoScrView addSubview:self.relativeScrView];
    [self.infoScrView addSubview:self.videoDetailScrView];
    
}
- (void)initSegmentCtrl{
    //初始化segment控件
    NSArray *items = @[@"视频详情", @"相关视频"];
    self.segmentCtrl = [[UISegmentedControl alloc] initWithItems: items];
    self.segmentCtrl.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    self.segmentCtrl.selectedSegmentIndex = 0;
    //添加委托方法
    [self.segmentCtrl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
}
- (void)initInfoScrollView{
    self.infoScrView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bigThumbnailImgView.frame.origin.y + self.bigThumbnailImgView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.segmentCtrl.frame.size.height)];
    
    [self.view addSubview:self.infoScrView];
}

- (void)initVideoDetailScrView{
    self.videoDetailScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentCtrl.frame.size.height, self.view.frame.size.width, self.infoScrView.frame.size.height)];
    self.videoDetailScrView.alwaysBounceVertical = YES;
    self.videoDetailScrView.scrollEnabled = YES;
    self.videoDetailScrView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    self.videoDetailScrView.showsHorizontalScrollIndicator = NO;
    self.videoDetailScrView.showsVerticalScrollIndicator = NO;
    self.videoDetailScrView.userInteractionEnabled = YES;
    self.videoDetailScrView.backgroundColor = [UIColor blueColor];
    self.videoDetailScrView.opaque = 1;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 100, 30)];
    label.text = [self.originData objectForKey:@"title"];
    [self.videoDetailScrView addSubview:label];
}

- (void)initRelativeScrollView{
    self.relativeScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentCtrl.frame.size.height, self.view.frame.size.width, self.infoScrView.frame.size.height)];
    self.relativeScrView.alwaysBounceVertical = YES;
    self.relativeScrView.scrollEnabled = YES;
    self.relativeScrView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    self.relativeScrView.showsHorizontalScrollIndicator = NO;
    self.relativeScrView.showsVerticalScrollIndicator = NO;
    self.relativeScrView.userInteractionEnabled = YES;
    self.relativeScrView.backgroundColor = [UIColor redColor];
    self.relativeScrView.opaque = 1;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 100, 30)];
    label.text = [self.originData objectForKey:@"description"];
    [self.relativeScrView addSubview:label];
}

//具体委托方法实例
-(void)segmentAction:(UISegmentedControl *)seg{
    
    NSInteger index = seg.selectedSegmentIndex;
    NSLog(@"index = %ld", (long)index);
    switch (index) {
            
        case 0:
            [self translateView:kCATransitionFromRight];
            break;
            
        case 1:
            [self translateView:kCATransitionFromLeft];
            break;
            
        default:
            
            break;
    }
}

-(void)translateView:(NSString *)side{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type  = @"oglFlip";
    animation.subtype = side;
    [self.infoScrView exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    [[self.infoScrView layer] addAnimation:animation forKey:@"animation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
