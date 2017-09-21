//
//  JKSecurityAESWrapper.h
//  Pods
//
//  Created by Futao on 16/4/13.
//
//

#import <Foundation/Foundation.h>
#import "JKSecurityWrapperResult.h"
#pragma mark - JKSecurityAESWrapper

@interface JKSecurityAESWrapper : NSObject
/**
 *  支持JAVA、Android、PHP、JS、C# 加密协议 AES/CBC/PKCS5Padding
 *  参考 https://github.com/keel/aes-cross
 */
#pragma mark - AES Encrypt
+ (JKSecurityWrapperResult *)encryptString:(NSString *)string key:(NSString *)key;
+ (JKSecurityWrapperResult *)encryptString:(NSString *)string hexKey:(NSString *)key hexIv:(NSString *)iv;
+ (JKSecurityWrapperResult *)encryptString:(NSString *)string key:(NSData *)key iv:(NSData *)iv;
+ (JKSecurityWrapperResult *)encryptData:(NSData *)data key:(NSData *)key iv:(NSData *)iv;
#pragma mark AES Decrypt
+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 key:(NSString *)key;
+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 hexKey:(NSString *)key hexIv:(NSString *)iv;
+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 key:(NSData *)key iv:(NSData *)iv;
+ (JKSecurityWrapperResult *)decryptData:(NSData *)data key:(NSData *)key iv:(NSData *)iv;

@end
