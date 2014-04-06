//
//  RefreshHeaderAndFooterView.h
//  hardy
//
//  Created by hardy on 13-1-8.
//  Copyright (c) 2013年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	PullRefreshPulling = 0,
	PullRefreshNormal,
	PullRefreshLoading,
} PullRefreshState;

//RefreshHeaderView
@interface RefreshHeaderView : UIView {
	
    UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
}
@property(nonatomic)PullRefreshState state;
- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor;
- (void)updateRefreshDate :(NSDate *)date;
@end


//RefreshHeaderAndFooterView
@protocol RefreshHeaderViewDelegate;

@interface RefreshScrollHeaderView : UIView{
}
@property(nonatomic,weak) id <RefreshHeaderViewDelegate> delegate;
@property(nonatomic,strong) RefreshHeaderView *refreshHeaderView;

- (void)RefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)RefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)RefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol RefreshHeaderViewDelegate
- (void)RefreshHeaderDidTriggerRefresh:(RefreshScrollHeaderView*)view;
- (BOOL)RefreshHeaderDataSourceIsLoading:(RefreshScrollHeaderView*)view;
@optional
- (NSDate*)RefreshHeaderDataSourceLastUpdated:(RefreshScrollHeaderView*)view;
@end