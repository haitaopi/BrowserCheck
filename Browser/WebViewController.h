//
//  WebViewController.h
//  Browser
//
//  Created by piht on 14-10-20.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebViewDelegate <NSObject>

- (void) clickOnBookmarkButton;

@end

@interface WebViewController : UIViewController <UITextFieldDelegate,UIWebViewDelegate>
{
}
@property (nonatomic,retain) UITextField *urlTextField;
@property (nonatomic,retain)UIButton  *cleanURLButton;
@property (nonatomic,retain)UIButton  *gotoURLButton;             
@property (nonatomic,retain)UIWebView *myWebView;
@property (nonatomic,retain)UIButton  *addBookmarkButton;
@property (nonatomic,retain)UIButton  *gotoBookmarkFolderButton;
@property (nonatomic,retain)UIButton  *goBackButton;
@property (nonatomic,retain)UIButton  *goForwardButton;

@property (nonatomic,assign) id<WebViewDelegate> delegateOfWebView;

- (void) buttonClickClean;
- (void) buttonClickGo;
- (void) buttonGoForward;
- (void) buttonGoBack;
- (void) buttonAddBookmark;
- (void) buttonGotoBookmarkFolder;
- (void) loadWebPageWithString:(NSString *)urlString;

- (BOOL) isTitleInPlistFile;
- (void) checkOnReturn;

@end
