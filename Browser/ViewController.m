//
//  ViewController.m
//  Browser
//
//  Created by piht on 14-10-20.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "BookmarkViewController.h"

@implementation ViewController

@synthesize myScrollView;
@synthesize myWebView;
@synthesize myBookmarkView;

- (id) init
{
    self = [super init];
    // todo
    return self;
}

- (void) dealloc
{
    //todo
    self.myWebView  = nil;
    self.myScrollView = nil;
    self.myBookmarkView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rect = [UIScreen mainScreen].bounds; 
    int width = rect.size.width;
    int height = rect.size.height-4;
    
    //myScrollView
    self.myScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)] autorelease];
    self.myScrollView.contentSize = CGSizeMake(width*2, height);
    [self.myScrollView setScrollEnabled:NO];
    
    //myWebview
    self.myWebView = [[[WebViewController alloc] init] autorelease];
    self.myWebView.view.frame = CGRectMake(0, 0, width, height);
    self.myWebView.delegateOfWebView = self;
    [self.myScrollView addSubview:self.myWebView.view];
    
    //myBookmarkView
    self.myBookmarkView = [[[BookmarkViewController alloc] init] autorelease];
    self.myBookmarkView.view.frame = CGRectMake(width, 0, width, height);
    self.myBookmarkView.delegateOfBookmark = self;
    [self.myScrollView addSubview:self.myBookmarkView.view];
    
    [self.view addSubview:self.myScrollView];
}

#pragma marks - delegate methods

- (void) clickOnBookmarkButton
{
    CGRect rect = [UIScreen mainScreen].bounds;
    [self.myScrollView scrollRectToVisible:CGRectMake(rect.size.width, 0, rect.size.width, rect.size.height) animated:YES];
    [self.myBookmarkView refreshTableView];
}

- (void) clickOnReturnButton
{
    CGRect rect = [UIScreen mainScreen].bounds;
    [self.myScrollView scrollRectToVisible:rect animated:YES];
    [self.myWebView checkOnReturn];
}

- (void) clickOnItemWithURL: (NSString *)urlString
{
    CGRect rect = [UIScreen mainScreen].bounds;
    [self.myScrollView scrollRectToVisible:rect animated:YES];
    [self.myWebView loadWebPageWithString:urlString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
