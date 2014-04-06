//
//  HomeViewController.m
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import "HomeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "Constants.h"
#import "MiddleImageView.h"
#import "BigImageView.h"
#import "DetailViewController.h"
#import "RefreshScrollHeaderView.h"

@interface HomeViewController ()<RefreshHeaderViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) RefreshScrollHeaderView * refreshScrollHeaderView;

@property (nonatomic, strong) UIScrollView *rootScrView;
@property (nonatomic, strong) UIScrollView *topScrView;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, unsafe_unretained) BOOL reloading;

- (void)initHomeView;
- (void)loadData;
- (void)clickHandler:(id)sender;
@end

@implementation HomeViewController

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

    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_youku"]];
    self.navigationItem.titleView = titleView;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_background"]];
    
    self.categories = [NSArray arrayWithObjects:@"电影", @"电视剧", @"综艺", @"动漫", @"体育", nil];
    
    [self initHomeView];
    
    [self loadData];
    self.reloading = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initHomeView{
    
    // init root scroll view
    self.rootScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.rootScrView.alwaysBounceVertical = YES;
    self.rootScrView.scrollEnabled = YES;
    self.rootScrView.contentSize = CGSizeMake(self.view.frame.size.width, TOP_SCROLL_HEIGHT + ROWS * SUBSCROLL_HEIGHT);
    self.rootScrView.showsHorizontalScrollIndicator = NO;
    self.rootScrView.showsVerticalScrollIndicator = NO;
    self.rootScrView.userInteractionEnabled = YES;
    self.rootScrView.delegate = self;
    [self.view addSubview:self.rootScrView];
    
    // 下拉刷新
    RefreshScrollHeaderView *refreshView = [[RefreshScrollHeaderView alloc] initWithFrame:CGRectMake(self.rootScrView.frame.origin.x, self.rootScrView.frame.origin.y, self.rootScrView.frame.size.width, self.rootScrView.contentSize.height)];
    [self.rootScrView addSubview:refreshView];
    self.refreshScrollHeaderView = refreshView;
    self.refreshScrollHeaderView.delegate = self;
    [self.refreshScrollHeaderView.refreshHeaderView updateRefreshDate:[NSDate date]];
    
    // init topscrollview
    self.topScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TOP_SCROLL_HEIGHT)];
    self.topScrView.alwaysBounceHorizontal = YES;
    self.topScrView.scrollEnabled = YES;
    self.topScrView.contentSize = CGSizeMake(COLS * self.view.frame.size.width, TOP_SCROLL_HEIGHT);
    self.topScrView.showsHorizontalScrollIndicator = NO;
    self.topScrView.pagingEnabled = YES;
    self.topScrView.userInteractionEnabled = YES;
    self.topScrView.tag = TOP_SCROLL_TAG;
    for (int col = 0; col < COLS; col++) {
        BigImageView *bigView = [[BigImageView alloc] initWithFrame:CGRectMake(col * self.view.frame.size.width, 0, self.view.frame.size.width, TOP_SCROLL_HEIGHT)];
        bigView.tag = col;
        [self.topScrView addSubview:bigView];
    }
    [self.rootScrView addSubview:self.topScrView];
    
    // init subscrollview
    for (int row = 0; row < self.categories.count; row++) {
       
        UIScrollView *scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, row * SUBSCROLL_HEIGHT + TOP_SCROLL_HEIGHT, self.view.frame.size.width, SUBSCROLL_HEIGHT)];
        scrView.alwaysBounceHorizontal = YES;
        scrView.scrollEnabled = YES;
        scrView.contentSize = CGSizeMake(COLS * IMG_WIDTH, SUBSCROLL_HEIGHT);
        scrView.showsHorizontalScrollIndicator = NO;
        scrView.tag = SCROLL_TAG + row;
        scrView.pagingEnabled = YES;
        scrView.userInteractionEnabled = YES;
        
        for (int col = 0; col < COLS; col++) {
            MiddleImageView *midView = [[MiddleImageView alloc] initWithFrame:CGRectMake(col * IMG_WIDTH, 0, IMG_WIDTH, SUBSCROLL_HEIGHT)];
            midView.tag = col;
            [scrView addSubview:midView];
        }
        [self.rootScrView addSubview:scrView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width - 40, (row + 1) * SUBSCROLL_HEIGHT + TOP_SCROLL_HEIGHT - 40, 40, 40);
        btn.tag = MORE_TAG + row;
        [btn setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"more_btn_selected"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(moreBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.rootScrView addSubview:btn];
    }
}

- (void)moreBtnHandler:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"moreBtnHandler is called! tag = %ld", btn.tag);
}

- (void)loadData{
    [self loadTopData];
    [self loadSubScrollData];
    [self.refreshScrollHeaderView RefreshScrollViewDataSourceDidFinishedLoading:self.rootScrView];
}

- (void)loadTopData{
    NSString *top_query_url = [TOP_QUERY_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    __weak __typeof(self)weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        [manager setResponseSerializer: [AFJSONResponseSerializer new]];
        [manager GET:top_query_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *rootDict = [responseObject objectForKey:@"videos"];
            
            // 拼接视频ids
            NSString *ids = [self parseVideoIds:@"id" withArray:rootDict];
            NSString *top_query_videos_url = [TOP_QUERY_VIDEOS_URL(ids)stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"top_query_videos_url = %@", TOP_QUERY_VIDEOS_URL(ids));
            [manager GET:top_query_videos_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSArray *videosDict = [responseObject objectForKey:@"videos"];
                    for (int col = 0; col < videosDict.count; col++) {
                        //NSLog(@"subDict = %@", subDict);
                        NSDictionary *subDict = [videosDict objectAtIndex:col];
                        
                        NSURL *image_url = [[NSURL alloc] initWithString:[subDict objectForKey:@"bigThumbnail"]];
                        
                        BigImageView *bigView = (BigImageView*)[weakSelf.topScrView viewWithTag:col];
                        [bigView setImgWithURL:image_url];
                        [bigView setTitle:[subDict objectForKey:@"title"]];
                        bigView.data = subDict;
                        UITapGestureRecognizer *uiTap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clickHandler:)];
                        [bigView addGestureRecognizer:uiTap];
                    }
                });
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    });
}

- (NSString*)parseVideoIds: (NSString*)key withArray:(NSArray*)array{
    // 拼接视频id
    NSMutableString *ids = [NSMutableString string];
    for (int col = 0; col < array.count; col++) {
        //NSLog(@"subDict = %@", subDict);
        NSDictionary *subDict = [array objectAtIndex:col];
        
        NSString *video_id = [subDict objectForKey:key];
        
        if (col < array.count - 1) {
            [ids appendFormat:@"%@,", video_id];
        }
        else{
            [ids appendString:video_id];
        }
    }
    NSLog(@"ids = %@", ids);
    return ids;
}

- (void)loadSubScrollData{
    for (int row = 0; row < self.categories.count; row++) {
        NSString *category = [self.categories objectAtIndex:row];
        NSString *query_url = [SUBSCROLL_QUERY_URL(category) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        __weak __typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
            [manager setResponseSerializer: [AFJSONResponseSerializer new]];
            [manager GET:query_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *rootDict = [responseObject objectForKey:@"shows"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    for (int col = 0; col < rootDict.count; col++) {
                        //NSLog(@"subDict = %@", subDict);
                        NSDictionary *subDict = [rootDict objectAtIndex:col];
                        
                        NSURL *image_url = [[NSURL alloc] initWithString:[subDict objectForKey:@"thumbnail"]];
                        
                        UIScrollView *subScrView = (UIScrollView *)[weakSelf.rootScrView viewWithTag:SCROLL_TAG + row];
                        MiddleImageView *midView = (MiddleImageView*)[subScrView viewWithTag:col];
                        [midView setImgWithURL:image_url];
                        [midView setTitle:[subDict objectForKey:@"name"]];
                        midView.data = subDict;
                        UITapGestureRecognizer *uiTap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clickHandler:)];
                        [midView addGestureRecognizer:uiTap];
                    }
                });
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        });
    }
}

- (void)clickHandler:(id)sender{
    UITapGestureRecognizer *tap = sender;
    CustomImageView *midView = (CustomImageView*) tap.view;
    NSLog(@"tag = %ld", tap.view.tag);
    NSLog(@"sender = %@", midView.data);
    
    DetailViewController *detailCtrl = [[DetailViewController alloc] init];
    detailCtrl.originData = midView.data;
    [self.navigationController pushViewController:detailCtrl animated:YES];
}

- (void)doneLoadingViewData{
	
    NSLog(@"doneLoadingViewData is called!");
	//  model should call this when its done loading
	self.reloading = NO;
    [self loadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
    [self.refreshScrollHeaderView RefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.refreshScrollHeaderView RefreshScrollViewDidEndDragging:scrollView];
	
}
#pragma mark -
#pragma mark RefreshHeaderAndFooterViewDelegate Methods

- (void)RefreshHeaderDidTriggerRefresh:(RefreshScrollHeaderView*)view{
	self.reloading = YES;
    if (view.refreshHeaderView.state == PullRefreshLoading) {//下拉刷新动作的内容
        NSLog(@"header");
        [self performSelector:@selector(doneLoadingViewData) withObject:nil afterDelay:3.0];
    }
}

- (BOOL)RefreshHeaderDataSourceIsLoading:(RefreshScrollHeaderView*)view{
	
	return self.reloading; // should return if data source model is reloading
	
}
- (NSDate*)RefreshHeaderDataSourceLastUpdated:(RefreshScrollHeaderView*)view{
    return [NSDate date];
}
@end
