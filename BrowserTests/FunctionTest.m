//
//  FunctionTest.m
//  Browser
//
//  Created by piht on 14-10-23.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import "FunctionTest.h"

@implementation FunctionTest

- (void) beforeAll{
}

- (void)test01_BasicWorkfllow
{
    /* the basic operations of the browser like clean the url, go to the specified
     website, move backward, move forward.
     */
    //init
    [tester waitForTimeInterval:1];
    UIButton * cleanURLButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Clean];
    UIButton * gotoURLButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Go];
    UIButton * goBackButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Back];
    UIButton * goForwardButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Forward];
    UIButton * addBookmarkButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Add];
    UIButton * gotoBookmarkFolderButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Bookmark];
    UIWebView *myWebView = (UIWebView *)[tester waitForViewWithAccessibilityLabel:UC_WebView];
    
    // do assertion jobs when open the browser for the first time
    XCTAssertTrue(![cleanURLButton isEnabled], "pass");
    XCTAssertTrue(![gotoURLButton isEnabled], "pass");
    XCTAssertTrue(![goBackButton isEnabled], "pass");
    XCTAssertTrue(![goForwardButton isEnabled], "pass");
    XCTAssertTrue(![addBookmarkButton isEnabled], "pass");
    XCTAssertTrue([gotoBookmarkFolderButton isEnabled], "pass");
    
    //input url and click go
    [tester enterText:@"http://www.baidu.com" intoViewWithAccessibilityLabel:UC_urlInputField];
    [tester tapViewWithAccessibilityLabel:UC_Menu_Go];
    [tester waitForTimeInterval:1];
    NSString * title = [myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    XCTAssertTrue([title isEqualToString:@"百度一下"], "pass");
    XCTAssertTrue([cleanURLButton isEnabled], "pass");
    XCTAssertTrue([gotoURLButton isEnabled], "pass");
    
    //clean the url
    [tester tapViewWithAccessibilityLabel:UC_Menu_Clean];
    [tester waitForTimeInterval:1];
    XCTAssertTrue(![cleanURLButton isEnabled], "pass");
    XCTAssertTrue(![gotoURLButton isEnabled], "pass");
    
    //input the url and click go
    [tester enterText:@"http://www.xiami.com" intoViewWithAccessibilityLabel:UC_urlInputField];
    [tester tapViewWithAccessibilityLabel:UC_Menu_Go];
    [tester waitForTimeInterval:1];
    XCTAssertTrue([goBackButton isEnabled], "pass");
    
    //tap back
    [tester tapViewWithAccessibilityLabel:UC_Menu_Back];
    [tester waitForTimeInterval:1];
    XCTAssertTrue([goForwardButton isEnabled], "pass");
    XCTAssertTrue(![goBackButton isEnabled], "pass");
    
    //tap forward
    [tester tapViewWithAccessibilityLabel:UC_Menu_Forward];
    [tester waitForTimeInterval:1];
    XCTAssertTrue(![goForwardButton isEnabled], "pass");
    XCTAssertTrue([goBackButton isEnabled], "pass");
}

- (void)test02_AddOneItem
{
    /*
     add one item that hasn't been added before into the bookmark folder
     */
    //go to the bookmark floder
    [tester waitForTimeInterval:1];
    [tester tapViewWithAccessibilityLabel:UC_Menu_Bookmark];
    [tester waitForTimeInterval:1];
    
    UITableView * myTabelView = (UITableView *)[tester waitForViewWithAccessibilityLabel:UC_TableView];
    UIButton * gotoBrowserButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Return];
    UIButton * deleteBookmarkButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_DeleteAll];
    int numberOfRowBeforeAdd = [myTabelView numberOfRowsInSection:0];
    XCTAssertTrue([gotoBrowserButton isEnabled], "pass");
    XCTAssertTrue([deleteBookmarkButton isEnabled], "pass");
    
    //return to the webview page
    [tester waitForTimeInterval:1];
    [tester tapViewWithAccessibilityLabel:UC_Menu_Return];
    
    //input the url
    [tester waitForTimeInterval:1];
    [tester clearTextFromViewWithAccessibilityLabel:UC_urlInputField];
    [tester enterText:@"http://www.sina.cn" intoViewWithAccessibilityLabel:UC_urlInputField];
    [tester tapViewWithAccessibilityLabel:UC_Menu_Go];
    [tester waitForTimeInterval:1];
    UIButton * addBookmarkButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Add];
    UIButton * gotoBookmarkFolderButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Bookmark];
    XCTAssertTrue([addBookmarkButton isEnabled], "pass");
    XCTAssertTrue([gotoBookmarkFolderButton isEnabled], "pass");
    
    //add to the bookmark floder
    [tester tapViewWithAccessibilityLabel:UC_Menu_Add];
    [tester waitForTimeInterval:1];
    XCTAssertTrue(![addBookmarkButton isEnabled], "pass");
    
    //go to the bookmark floder
    [tester tapViewWithAccessibilityLabel:UC_Menu_Bookmark];
    [tester waitForTimeInterval:1];
    int numberOfRowAfterAdd = [myTabelView numberOfRowsInSection:0];
    XCTAssertTrue(numberOfRowAfterAdd == (numberOfRowBeforeAdd+1), "pass");
    
    //return to the webview page
    [tester tapViewWithAccessibilityLabel:UC_Menu_Return];
}


- (void)test03_OpenOneItem
{
    /*
     open the specified url from the bookmark folder.
     */
    //input the url
    [tester waitForTimeInterval:1];
    [tester clearTextFromViewWithAccessibilityLabel:UC_urlInputField];
    [tester enterText:@"http://www.baidu.com" intoViewWithAccessibilityLabel:UC_urlInputField];
    [tester tapViewWithAccessibilityLabel:UC_Menu_Go];
    [tester waitForTimeInterval:1];
    UIWebView *myWebView = (UIWebView *)[tester waitForViewWithAccessibilityLabel:UC_WebView];
    NSString * baiduTitle = [myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    XCTAssertTrue([baiduTitle isEqualToString:@"百度一下"], "pass");
    
    //go to bookmark folder
    [tester tapViewWithAccessibilityLabel:UC_Menu_Bookmark];
    [tester waitForTimeInterval:1];
    
    //open one item
    [tester tapViewWithAccessibilityLabel:@"UC_Menu_Cell1"];
    [tester waitForTimeInterval:2];
    NSString * sinaTitle = [myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    XCTAssertTrue([sinaTitle isEqualToString:@"手机新浪网"], "pass");
    UIButton * addBookmarkButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Add];
    XCTAssertTrue(![addBookmarkButton isEnabled], "pass");
}

 - (void)test04_DeleteOneItem
 {
     /*
      delete one item from the bookmarkfolder
      */
     //go to the bookmark floder
     [tester waitForTimeInterval:1];
     [tester tapViewWithAccessibilityLabel:UC_Menu_Bookmark];
     [tester waitForTimeInterval:1];
     UIButton * UC_Menu_DeleteItem1 = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"UC_Menu_Delete1"];
     XCTAssertTrue([UC_Menu_DeleteItem1 isEnabled], "pass");
     UITableView * myTabelView = (UITableView *)[tester waitForViewWithAccessibilityLabel:UC_TableView];
     int numberOfRowBeforeDelete = [myTabelView numberOfRowsInSection:0];
     
     //delete one item
     [tester tapViewWithAccessibilityLabel:@"UC_Menu_Delete1"];
     [tester waitForTimeInterval:1];
     int numberOfRowAfterDelete = [myTabelView numberOfRowsInSection:0];
     XCTAssertTrue(numberOfRowBeforeDelete == (numberOfRowAfterDelete+1), "pass");

     //return to webview
     [tester tapViewWithAccessibilityLabel:UC_Menu_Return];
 }

- (void)test05_DeleteAllItem
{
    /*
     delete all items from the bookmark folder.
     */
    [tester waitForTappableViewWithAccessibilityLabel:UC_urlInputField];
    [tester clearTextFromViewWithAccessibilityLabel:UC_urlInputField];
    [tester enterText:@"http://www.sina.cn" intoViewWithAccessibilityLabel:UC_urlInputField];
    [tester tapViewWithAccessibilityLabel:UC_Menu_Go];
    [tester waitForTimeInterval:2];
    
    [tester tapViewWithAccessibilityLabel:UC_Menu_Add];
    [tester waitForTimeInterval:1];
    
    [tester tapViewWithAccessibilityLabel:UC_Menu_Bookmark];
    [tester waitForTimeInterval:1];
 
    [tester tapViewWithAccessibilityLabel:UC_Menu_DeleteAll];
    [tester waitForTimeInterval:1];
    UITableView * myTabelView = (UITableView *)[tester waitForViewWithAccessibilityLabel:UC_TableView];
    int numberOfRowAfterDeleteAll = [myTabelView numberOfRowsInSection:0];
    XCTAssertTrue(numberOfRowAfterDeleteAll == 0, "pass");
    
    [tester tapViewWithAccessibilityLabel:UC_Menu_Return];
    [tester waitForTimeInterval:1];
    UIButton * addBookmarkButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:UC_Menu_Add];
    XCTAssertTrue([addBookmarkButton isEnabled], "pass");
}

@end
