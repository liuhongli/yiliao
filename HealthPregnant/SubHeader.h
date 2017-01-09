//
//  RMinViewController.m
//  JSClient
//
//  Created by  honely on 15/8/17.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#ifndef PickPick_SubHeader_h
#define PickPick_SubHeader_h

#define DEBUG 1  // 1- Debug 0-Release

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

/*!
 *  @author Alice
 *
 *  @brief  ID AND KEY For ...
 */
#define APPID   @"vmvwrso7stvp5vmzccs0a6zqa37nddpjn8hn30fsq985rbnf"
#define APPKEY  @"yww7pshcw3hs6uciwojxbl3dq085g1oj9uv7bvk4g6ogu5xm"

/// Navigation Height
#define NAVI_BAR_HEIGHT 64.0f
// 6Plus main screen width
#define iPhone6PlusWidth 414.000000

/// Status Bar
#define STATUSBAR_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height

/// System Version
#define IOS_FSystenVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS_DSystenVersion ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define IOS_SSystemVersion ([[UIDevice currentDevice] systemVersion])
#define iPhone1G           @"iPhone1,1"
#define iPhone3G           @"iPhone1,2"
#define iPhone3Gs          @"iPhone2,1"
#define iPhone4            @"iPhone3,1"
#define iPhone4S           @"iPhone4,1"
#define iPhone5            @"iPhone5,2"
#define iPhone6            @"iPhone6,1"
#define iPhone6Plus        @"iPhone6,2"
#define iPod1G             @"iPod1,1"
#define iPodTouch2G        @"iPod2,1"
#define iPodTouch3G        @"iPod3,1"
#define iPodTouch4G        @"iPod4,1"
#define iPad               @"iPad1,1"
#define iPad2WiFi          @"iPad2,1"
#define iPad2_GSM          @"iPad2,2"
#define iPad2_CDMA         @"iPad2,3"
#define Simulator64        @"x86_64"
#define Simulator32        @"i386"


/// Application Language
#define CURRENTLANGUAGE    ([[NSLocale preferredLanguages] objectAtIndex:0])

/// Screen size
#define SCREEN_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] applicationFrame].size.width

/// Color
#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// Main Color
#define ADLIGHT_BLUE_(alp)  RGBACOLOR(86, 150, 220, alp)
#define ADLIGHT_BLUE        RGBCOLOR(86, 150, 220)
#define ADDARK_BLUE_(alp)   RGBACOLOR(55, 91, 130, alp)
#define ADDARK_BLUE         RGBCOLOR(55, 91, 130)

#define MainColor           [UIColor purpleColor]

/// Text Color
#define TextColor           [UIColor whiteColor]
#define TextLightGrayColor  [UIColor lightGrayColor] 
#define TextDarkGrayColor   [UIColor darkGrayColor]

/// Fonts
#define FONT(s) [UIFont systemFontOfSize:s]

/// Image
#define LOCAL_IMG(img)   [UIImage imageNamed:img]

/// UserDefault
#define XW_USERDEFAULT [NSUserDefaults standardUserDefaults]
#define XW_CURRENT_USER @"currentUserName"
#define XW_CURRENT_PASSWORD @"currentPassword"
#define XW_IS_LOGIN @"isLogin"

#define XW_SAVE(OBJC, KEY, VALUE)       [(OBJC) setObject:(VALUE) forKey:(KEY)] // Save Online
#define XW_SAVEL(OBJC, KEY, VALUE)      [(OBJC) setValue:(VALUE) forKey:(KEY)]  // Save Local
#define XW_SAVE_BOLEAN(OBJC,KEY,BOOL)   [(OBJC) setBool:(BOOL) forKey:(KEY)]    // Save BOOL



#define XW_GETW(OBJC, KEY) [(OBJC)  objectForKey:(KEY)] // Online Data
#define XW_GETL(OBJC, KEY) [(OBJC)  valueForKey:(KEY)]  // Local Data

/// String with Class
#define XW_STRINGWITHCLASS(PARM) NSStringFromClass(PARM)
#define XW_CLSSFROMSTRING(PARM)  NSClassFromString(PARM)


// CoreData
#define XW_MISSION_ENTITY_DESC  [NSEntityDescription entityForName:@"Mission" inManagedObjectContext:[[CoreDataManager defaultManager] managedObjectContext]]  // Mission entity description
#define XW_HOST_ENTITY_DESC [NSEntityDescription entityForName:@"Host" inManagedObjectContext:[[CoreDataManager defaultManager] managedObjectContext]]  // Host entity description
#define XW_ManagedObjContext    [CoreDataManager defaultManager] managedObjectContext]   // managed object context


/**
 *  EeseMob
 */

#import <Availability.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]


#define MR_SHORTHAND






#endif
