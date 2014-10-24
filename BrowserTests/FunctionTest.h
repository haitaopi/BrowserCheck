//
//  FunctionTest.h
//  Browser
//
//  Created by piht on 14-10-23.
//  Copyright (c) 2014年 piht. All rights reserved.
//

#import <KIF/KIF.h>

#define UC_AccessibilityLabelName
#ifdef UC_AccessibilityLabelName

#define UC_urlInputField @"UC_Menu_URL"
#define UC_Menu_Clean @"UC_Menu_Clean"
#define UC_Menu_Go @"UC_Menu_Go"
#define UC_WebView @"UC_WebView"
#define UC_Menu_Back @"UC_Menu_Back"
#define UC_Menu_Forward @"UC_Menu_Forward"
#define UC_Menu_Add @"UC_Menu_Add"
#define UC_Menu_Bookmark @"UC_Menu_Bookmark"

#define UC_TableView @"UC_TableView"
#define UC_Menu_Return @"UC_Menu_Return"
#define UC_Menu_DeleteAll @"UC_Menu_DeleteAll"
#endif

@interface FunctionTest : KIFTestCase

@end
