//
//  BookmarkViewController.m
//  Browser
//
//  Created by piht on 14-10-20.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import "BookmarkViewController.h"

@implementation BookmarkViewController

@synthesize bookmarkLabel;
@synthesize bookmarkFolderDict;
@synthesize bookmarkTableView;
@synthesize gotoBrowserButton;
@synthesize deleteBookmarkButton;
@synthesize delegateOfBookmark;

- (id) init
{
    self = [super init];
    //todo
    return self;
}

- (void)dealloc
{
    //todo
    self.bookmarkLabel = nil;
    self.bookmarkFolderDict = nil;
    self.bookmarkTableView = nil;
    self.gotoBrowserButton = nil;
    self.deleteBookmarkButton = nil;
    self.delegateOfBookmark = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = [UIScreen mainScreen].bounds;

    // Do any additional setup after loading the view.
    self.bookmarkLabel = [[[UILabel alloc] init] autorelease];
    [self.bookmarkLabel setFrame:CGRectMake(2, 20, rect.size.width-4, rect.size.height/20)];
    [self.bookmarkLabel setText:@"收藏夹"];
    [self.bookmarkLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.bookmarkLabel];
    
    //m_bookmarkTableView
    self.bookmarkTableView= [[[UITableView alloc] initWithFrame:CGRectMake(2,rect.size.height/20+20,rect.size.width-4,rect.size.height-rect.size.height/10-20) style:UITableViewStylePlain] autorelease];
    self.bookmarkTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.bookmarkTableView.delegate = self;
    self.bookmarkTableView.dataSource = self;
    [self.bookmarkTableView setAccessibilityLabel:@"UC_TableView"];
    [self.bookmarkTableView setIsAccessibilityElement:YES];
    [self.view addSubview:self.bookmarkTableView];
    
    //m_gotoBrowserButton
    self.gotoBrowserButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.gotoBrowserButton setFrame:CGRectMake(rect.size.width/2, rect.size.height-rect.size.height/20, rect.size.width/2, rect.size.height/20)];
    [self.gotoBrowserButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.gotoBrowserButton setEnabled:YES];
    [self.gotoBrowserButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.gotoBrowserButton addTarget:self action:@selector(buttonClickReturn) forControlEvents:UIControlEventTouchUpInside];
    [self.gotoBrowserButton setAccessibilityLabel:@"UC_Menu_Return"];
    [self.gotoBrowserButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.gotoBrowserButton];
    
    //m_deleteBookmarkButton
    self.deleteBookmarkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.deleteBookmarkButton setFrame:CGRectMake(2, rect.size.height-rect.size.height/20, rect.size.width/2, rect.size.height/20)];
    [self.deleteBookmarkButton setTitle:@"删除所有" forState:UIControlStateNormal];
    [self.deleteBookmarkButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.deleteBookmarkButton addTarget:self action:@selector(buttonClickDelete) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBookmarkButton setAccessibilityLabel:@"UC_Menu_DeleteAll"];
    [self.deleteBookmarkButton setIsAccessibilityElement:YES];
    [self.view addSubview:self.deleteBookmarkButton];
    
}

- (void) refreshTableView
{
    /* Invoked by clicking button "收藏夹" from WebViewControl, this function is used to update the TableView.
     */
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bookmark" ofType:@"plist"];
    self.bookmarkFolderDict = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] autorelease];
    [self.deleteBookmarkButton setEnabled:([[self.bookmarkFolderDict allKeys] count] == 0)? NO:YES];
    [self.bookmarkTableView reloadData];
}

- (void) buttonClickReturn
{
    //CGRect rect = [UIScreen mainScreen].bounds;
    [self.delegateOfBookmark clickOnReturnButton];
}

- (void) buttonClickDelete
{
    /* Invoked by clicking the button "删除所有", this function is used to delete all bookmarks from bookmark folder.
     */
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bookmark" ofType:@"plist"];
    
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    [plistData removeAllObjects];
    [plistData writeToFile:plistPath atomically:YES];
    [self.bookmarkFolderDict removeAllObjects];
    [self.bookmarkTableView reloadData];
    [self.deleteBookmarkButton setEnabled:NO];
}

#pragma marks delegate methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.bookmarkFolderDict allKeys] count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.height/10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"myTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (nil == cell)
    {
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier] autorelease];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [[self.bookmarkFolderDict allKeys] objectAtIndex:row];
    CGRect rect = [UIScreen mainScreen].bounds;
    
    //add the text and the button for the cell
    UIButton *deleteItemButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteItemButton.frame = CGRectMake(rect.size.width*4/5, 0, rect.size.width/5, rect.size.height/10);
    NSString * title = [NSString stringWithFormat:@"Del%lu",(unsigned long)row];
    [deleteItemButton setTitle:title forState:UIControlStateNormal];
    [deleteItemButton addTarget:self action:@selector(buttonRemoveItem:) forControlEvents:UIControlEventTouchUpInside];
    [deleteItemButton setAccessibilityLabel:[NSString stringWithFormat:@"UC_Menu_Delete%lu",(unsigned long)row]];
    [deleteItemButton setIsAccessibilityElement:YES];
    [cell addSubview:deleteItemButton];
    [cell setAccessibilityLabel:[NSString stringWithFormat:@"UC_Menu_Cell%lu",(unsigned long)row]];
    [cell setIsAccessibilityElement:YES];
	return cell;
}

- (void) buttonRemoveItem:(id) sender
{
    /* Invoked by tapping on the item, this function is used to delete one website from bookmark folder.
     */
    UIButton * button = (UIButton*) sender;
    NSString * string = [[button titleLabel] text];
    
    #warning 还有别的方法取到行的信息么，现实中不可能让你这样命名的
    NSUInteger row = [[string substringFromIndex:3] integerValue];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bookmark" ofType:@"plist"];
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    [plistData removeObjectForKey:[[self.bookmarkFolderDict allKeys] objectAtIndex:row]];
    [plistData writeToFile:plistPath atomically:YES];

    [self.bookmarkFolderDict removeObjectForKey:[[self.bookmarkFolderDict allKeys] objectAtIndex:row]];
    [self.deleteBookmarkButton setEnabled:[[self.bookmarkFolderDict allKeys] count]];
    [self.bookmarkTableView reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [[self.bookmarkFolderDict allKeys] objectAtIndex:[indexPath row]];
    NSString *urlString = [self.bookmarkFolderDict objectForKey:string];
    [self.delegateOfBookmark clickOnItemWithURL:urlString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
