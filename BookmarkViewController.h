//
//  BookmarkViewController.h
//  Browser
//
//  Created by piht on 14-10-20.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookmarkDelegate <NSObject>

- (void) clickOnReturnButton;
- (void) clickOnItemWithURL: (NSString *)urlString;

@end

@interface BookmarkViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
}

@property (nonatomic, retain) UILabel * bookmarkLabel;
@property (nonatomic, retain) NSMutableDictionary * bookmarkFolderDict;
@property (nonatomic, retain) UITableView * bookmarkTableView;
@property (nonatomic, retain) UIButton * gotoBrowserButton;
@property (nonatomic, retain) UIButton * deleteBookmarkButton;

@property (nonatomic,assign) id<BookmarkDelegate> delegateOfBookmark;

- (void) buttonClickReturn;
- (void) buttonClickDelete;
- (void) refreshTableView;
@end
