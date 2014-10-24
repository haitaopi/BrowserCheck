//
//  ViewController.h
//  Browser
//
//  Created by piht on 14-10-20.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "BookmarkViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate,BookmarkDelegate,WebViewDelegate>
{
}

@property (nonatomic,retain) UIScrollView * myScrollView;
@property (nonatomic,retain) WebViewController * myWebView;
@property (nonatomic,retain) BookmarkViewController * myBookmarkView;

@end
