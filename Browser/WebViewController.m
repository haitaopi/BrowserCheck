//
//  WebViewController.m
//  Browser
//
//  Created by piht on 14-10-20.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize urlTextField;
@synthesize cleanURLButton;
@synthesize gotoURLButton;
@synthesize myWebView;
@synthesize addBookmarkButton;
@synthesize gotoBookmarkFolderButton;
@synthesize goBackButton;
@synthesize goForwardButton;
@synthesize delegateOfWebView;

- (id) init
{
    self = [super init];
    //todo
    return self;
}

- (void)dealloc
{
    //todo
    self.urlTextField = nil;
    self.cleanURLButton = nil;
    self.gotoURLButton = nil;
    self.myWebView = nil;
    self.goBackButton = nil;
    self.goForwardButton = nil;
    self.addBookmarkButton = nil;
    self.delegateOfWebView = nil;
    self.gotoBookmarkFolderButton = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = [UIScreen mainScreen].bounds;
    
    //m_urlTextField
    self.urlTextField = [[[UITextField alloc] init] autorelease];
    [self.urlTextField setFrame:CGRectMake(2, 20, rect.size.width*4/5-4, rect.size.height/20)];
    [self.urlTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.urlTextField setPlaceholder:@"请输入URL: "];
    [self.urlTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.urlTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.urlTextField setKeyboardType:UIKeyboardTypeURL];
    [self.urlTextField setReturnKeyType:UIReturnKeyGo];
    [self.urlTextField setDelegate:self];
    [self.urlTextField setAccessibilityLabel:@"UC_Menu_URL"];
    [self.urlTextField setIsAccessibilityElement:YES];
    [self.view addSubview:self.urlTextField];
    
    
    //m_cleanURLButton
    self.cleanURLButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.cleanURLButton setFrame:CGRectMake(rect.size.width-rect.size.width/5-2, 20, rect.size.width/10, rect.size.height/20)];
    [self.cleanURLButton setTitle:@"清除" forState:UIControlStateNormal];
    [self.cleanURLButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.cleanURLButton addTarget:self action:@selector(buttonClickClean) forControlEvents:UIControlEventTouchUpInside];
    [self.cleanURLButton setEnabled:NO];
    [self.cleanURLButton setAccessibilityLabel:@"UC_Menu_Clean"];
    [self.cleanURLButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.cleanURLButton];
    
    
    //m_gotoURLButton
    //self.m_gotoURLButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gotoURLButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.gotoURLButton setFrame:CGRectMake(rect.size.width-rect.size.width/10-2, 20, rect.size.width/10, rect.size.height/20)];
    //UIImage *btnImage = [UIImage imageNamed:@"go.png"];
    //[self.m_gotoURLButton setImage:btnImage forState:UIControlStateNormal];
    [self.gotoURLButton setTitle:@"前往" forState:UIControlStateNormal];
    [self.gotoURLButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.gotoURLButton addTarget:self action:@selector(buttonClickGo) forControlEvents:UIControlEventTouchUpInside];
    [self.gotoURLButton setEnabled:NO];
    [self.gotoURLButton setAccessibilityLabel:@"UC_Menu_Go"];
    [self.gotoURLButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.gotoURLButton];
    
    
    //m_webView
    self.myWebView = [[[UIWebView alloc] init] autorelease];
    [self.myWebView setFrame:CGRectMake(0, rect.size.height/20+20, rect.size.width, rect.size.height-rect.size.height/10-20)];
    [self.myWebView setScalesPageToFit:YES];
    [self.myWebView setDelegate:self];
    [self.myWebView setAccessibilityLabel:@"UC_WebView"];
    [self.myWebView setIsAccessibilityElement:YES];
    [self.view addSubview:self.myWebView];
    
    //m_goBackButton
    self.goBackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.goBackButton setFrame:CGRectMake(2, rect.size.height-rect.size.height/20, rect.size.width/4, rect.size.height/20)];
    [self.goBackButton setTitle:@"后退" forState:UIControlStateNormal];
    [self.goBackButton setEnabled:NO];
    [self.goBackButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.goBackButton addTarget:self action:@selector(buttonGoBack) forControlEvents:UIControlEventTouchUpInside];
    [self.goBackButton setAccessibilityLabel:@"UC_Menu_Back"];
    [self.goBackButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.goBackButton];
    
    
    //m_goForwardButton
    self.goForwardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.goForwardButton setFrame:CGRectMake(rect.size.width/4, rect.size.height-rect.size.height/20, rect.size.width/4, rect.size.height/20)];
    [self.goForwardButton setTitle:@"前进" forState:UIControlStateNormal];
    [self.goForwardButton setEnabled:NO];
    [self.goForwardButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.goForwardButton addTarget:self action:@selector(buttonGoForward) forControlEvents:UIControlEventTouchUpInside];
    [self.goForwardButton setAccessibilityLabel:@"UC_Menu_Forward"];
    [self.goForwardButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.goForwardButton];
    
    
    //m_addBookmarkButton
    self.addBookmarkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addBookmarkButton setFrame:CGRectMake(rect.size.width/2, rect.size.height-rect.size.height/20, rect.size.width/4, rect.size.height/20)];
    [self.addBookmarkButton setTitle:@"收藏" forState:UIControlStateNormal];
    [self.addBookmarkButton setEnabled:NO];
    [self.addBookmarkButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.addBookmarkButton addTarget:self action:@selector(buttonAddBookmark) forControlEvents:UIControlEventTouchUpInside];
    [self.addBookmarkButton setAccessibilityLabel:@"UC_Menu_Add"];
    [self.addBookmarkButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.addBookmarkButton];
    
    
    //m_gotoBookmarkFolderButton
    self.gotoBookmarkFolderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.gotoBookmarkFolderButton setFrame:CGRectMake(rect.size.width*3/4, rect.size.height-rect.size.height/20, rect.size.width/4, rect.size.height/20)];
    [self.gotoBookmarkFolderButton setTitle:@"收藏夹" forState:UIControlStateNormal];
    [self.gotoBookmarkFolderButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.gotoBookmarkFolderButton addTarget:self action:@selector(buttonGotoBookmarkFolder) forControlEvents:UIControlEventTouchUpInside];
    [self.gotoBookmarkFolderButton setAccessibilityLabel:@"UC_Menu_Bookmark"];
    [self.gotoBookmarkFolderButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.gotoBookmarkFolderButton];
}

- (void) buttonClickClean{
    /*invoked by clicking the button "清除", this function is used to clean the url.
     */
    [self.urlTextField setText:@""];
    [self.addBookmarkButton setEnabled:NO];
    [self.addBookmarkButton setTitle:@"收藏"forState:UIControlStateNormal];
    [self.cleanURLButton setEnabled:NO];
    [self.gotoURLButton setEnabled:NO];
}

- (void) buttonClickGo
{
    if (![[self.urlTextField text] isEqualToString:@""])
    {
        [self.urlTextField resignFirstResponder];
        [self loadWebPageWithString:[self.urlTextField text]];
    }
}

- (void) buttonGoForward
{
    [self.myWebView goForward];
}

- (void) buttonGoBack
{
    [self.myWebView goBack];
}

- (void) buttonAddBookmark
{
    /*invoked by clicking the button "收藏", this function is used to add the current url to bookmark folder.
     */
    [self.addBookmarkButton setTitle:@"已收藏"forState:UIControlStateNormal];
    [self.addBookmarkButton setEnabled:NO];
    
    // check whether this url has been added to bookmark folder.
    if ((![self isTitleInPlistFile]) && ([self.urlTextField text]))
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bookmark" ofType:@"plist"];
        NSString * title = [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
        NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        [plistData setObject:[self.urlTextField text] forKey:title];
        [plistData writeToFile:plistPath atomically:YES];
    }
}

- (void) buttonGotoBookmarkFolder
{
    [self.delegateOfWebView clickOnBookmarkButton];
    /*
    CGRect rect = [UIScreen mainScreen].bounds;
    [self.delegateOfWebView gotoBookmarkfolder:CGRectMake(rect.size.width, 0, rect.size.width, rect.size.height)];
     */
}

- (void) loadWebPageWithString:(NSString *)urlString
{
    NSURL *url = nil;
    if ([urlString hasPrefix:@"http://"])
    {
        url = [NSURL URLWithString:urlString];
    }
    else
    {
        url = [NSURL URLWithString:[@"http://" stringByAppendingString:urlString]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}

- (BOOL) isTitleInPlistFile
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bookmark" ofType:@"plist"];
    NSMutableDictionary *data = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] autorelease];
    NSString * title = [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    return ([data objectForKey:title]?YES:NO);
}

- (void) checkOnReturn
{
    if (![[self.urlTextField text] isEqualToString:@""])
    {
        if (![self isTitleInPlistFile])
        {
            [self.addBookmarkButton setEnabled:YES];
            [self.addBookmarkButton setTitle:@"收藏"forState:UIControlStateNormal];
        }
        else
        {
            [self.addBookmarkButton setEnabled:YES];
            [self.addBookmarkButton setTitle:@"已收藏"forState:UIControlStateNormal];
            [self.addBookmarkButton setEnabled:NO];
        }
    }
    else
    {
        [self.addBookmarkButton setEnabled:YES];
        [self.addBookmarkButton setTitle:@"收藏"forState:UIControlStateNormal];
        [self.addBookmarkButton setEnabled:NO];
    }
}

#pragma marks - delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![[self.urlTextField text] isEqualToString:@""])
    {
        [self loadWebPageWithString:[self.urlTextField text]];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.gotoURLButton setEnabled:YES];
    [self.cleanURLButton setEnabled:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([[self.urlTextField text] isEqualToString:@""])
    {
        [self.gotoURLButton setEnabled:NO];
        [self.cleanURLButton setEnabled:NO];
    }
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.goForwardButton setEnabled:[myWebView canGoForward]];
    [self.goBackButton setEnabled:[myWebView canGoBack]];
    [self.cleanURLButton setEnabled:YES];
    [self.gotoURLButton setEnabled:YES];
    if (![self isTitleInPlistFile])
    {
        [self.addBookmarkButton setEnabled:YES];
        [self.addBookmarkButton setTitle:@"收藏"forState:UIControlStateNormal];
    }
    else
    {
        [self.addBookmarkButton setEnabled:YES];
        [self.addBookmarkButton setTitle:@"已收藏"forState:UIControlStateNormal];
        [self.addBookmarkButton setEnabled:NO];
    }
    NSString *currentURL = self.myWebView.request.URL.absoluteString;
    [self.urlTextField setText:currentURL];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Confirm", nil];
    [alertview show];
    [alertview release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
