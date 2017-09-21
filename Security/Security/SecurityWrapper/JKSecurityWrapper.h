//
//  JKSecurityWrapper.h
//  Pods
//
//  Created by Futao on 16/4/7.
//
//

// !!! 框架来源：https://github.com/kelp404/CocoaSecurity

#import <Foundation/Foundation.h>
#import "JKSecurityWrapperResult.h"

#pragma mark - JKSecurityWrapper
@interface JKSecurityWrapper : NSObject
#pragma mark - MD5
+ (JKSecurityWrapperResult *)md5:(NSString *)hashString;
+ (JKSecurityWrapperResult *)md5WithData:(NSData *)hashData;
#pragma mark HMAC-MD5
+ (JKSecurityWrapperResult *)hmacMd5:(NSString *)hashString hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacMd5WithData:(NSData *)hashData hmacKey:(NSString *)key;

#pragma mark - SHA
+ (JKSecurityWrapperResult *)sha1:(NSString *)hashString;
+ (JKSecurityWrapperResult *)sha1WithData:(NSData *)hashData;
+ (JKSecurityWrapperResult *)sha224:(NSString *)hashString;
+ (JKSecurityWrapperResult *)sha224WithData:(NSData *)hashData;
+ (JKSecurityWrapperResult *)sha256:(NSString *)hashString;
+ (JKSecurityWrapperResult *)sha256WithData:(NSData *)hashData;
+ (JKSecurityWrapperResult *)sha384:(NSString *)hashString;
+ (JKSecurityWrapperResult *)sha384WithData:(NSData *)hashData;
+ (JKSecurityWrapperResult *)sha512:(NSString *)hashString;
+ (JKSecurityWrapperResult *)sha512WithData:(NSData *)hashData;
#pragma mark HMAC-SHA
+ (JKSecurityWrapperResult *)hmacSha1:(NSString *)hashString hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha1WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha224:(NSString *)hashString hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha224WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha256:(NSString *)hashString hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha256WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha384:(NSString *)hashString hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha384WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha512:(NSString *)hashString hmacKey:(NSString *)key;
+ (JKSecurityWrapperResult *)hmacSha512WithData:(NSData *)hashData hmacKey:(NSString *)key;
@end

