
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>



typedef enum {
    NETWORK_TYPE_NONE= 0,
    NETWORK_TYPE_WIFI= 1,
    NETWORK_TYPE_3G= 2,
    NETWORK_TYPE_2G= 3,
}NETWORK_TYPE;
@interface Utility : NSObject {
    
}
+(void)changePortraitHead:(UIButton*)headPhotoBtn;
+(void)changePortraitImg:(UIImageView*)imageview;
+(void)changePortraitImg:(UIImageView*)imageview wight:(CGFloat)wight;
+(BOOL)isLoging:(UIViewController*)controller;

+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller;

+(NSString*) formatSeconds:(int)value;
+(NSString *)createMD5:(NSString *)params;
+(NSString *)createPostURL:(NSMutableDictionary *)params;
+(NSString *)getCurrentDate;
+(BOOL) connectedToNetwork;
+(BOOL) hostAvailable: (NSString *) theHost;
+(BOOL)isValidateEmail:(NSString *)email;
+(BOOL)isValidateString:(NSString *)myString;
+(BOOL)validateMobile:(NSString *)mobileNum;
+(int)dataNetworkTypeFromStatusBar;
+(id)dicToEntity:(NSDictionary *) dic obj:(id)obj;
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+(UIImage *)createImageWithColor:(UIColor *)color;
+(BOOL) isNotEmptyString:(NSString *)string;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSString* ) folderSizeAtPath:(NSString*) folderPath;

+(void)back:(UIViewController*)viewController;
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
+(CGFloat)boundingRectWithSize:(UIFont*)fonts width:(CGFloat)width string:(NSString*)string;
+ (void)sendPay:(NSString*)orderId;

@end
