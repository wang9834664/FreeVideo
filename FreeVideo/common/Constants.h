//
//  Constants.h
//  FreeVideo
//
//  Created by wang on 14-3-28.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define COLS 6
#define ROWS 5
#define IMG_WIDTH 160
#define IMG_HEIGHT 90
#define BIG_IMG_WIDTH 320
#define BIG_IMG_HEIGHT 180
#define SCROLL_TAG 100
#define MORE_TAG 200
#define SUBSCROLL_HEIGHT (IMG_HEIGHT + 20)
#define MORE_IMG_WIDTH_HEIGHT 40
#define TOP_SCROLL_HEIGHT 180
#define TOP_SCROLL_TAG 99


#define CLIENT_ID @"3ecad3b383d1b8c2"
#define HOST_URL @"http://openapi.youku.com/v2"

#define TOP_QUERY_URL [NSString stringWithFormat:@"%@/videos/by_category.json?client_id=%@&count=%d&category=%@",HOST_URL, CLIENT_ID, COLS, @"资讯"]

#define TOP_QUERY_VIDEOS_URL(ids) [NSString stringWithFormat:@"%@/videos/show_batch.json?client_id=%@&video_ids=%@&ext=bigThumbnail,duration,title,id", HOST_URL, CLIENT_ID, ids]

#define SUBSCROLL_QUERY_URL(category) [NSString stringWithFormat:@"%@/shows/by_category.json?client_id=%@&count=%d&category=%@", HOST_URL, CLIENT_ID, COLS, category]

#define LOADING_IMG [UIImage imageNamed:@"img_loading"]

@interface Constants : NSObject

@end
