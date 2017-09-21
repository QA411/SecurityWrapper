//
//  JKSecurityRSAWrapper.h
//  Pods
//
//  Created by Futao on 16/4/13.
//
//

#import <Foundation/Foundation.h>
#import "JKSecurityWrapperResult.h"

#pragma mark - JKSecurityRSAWrapper
/**
 *  公钥加密-私钥解密、公钥解密、私钥加密 （为了客户端安全，客户端一般都只保存公钥）
 *  支持JAVA、Android、PHP、JS、C#
 */
@interface JKSecurityRSAWrapper : NSObject
#pragma mark - RSA Encrypt
/**
 *  加密 公钥加密
 *  IOS-SDK默认不支持私钥加密，如果需要请使用OPENSSL框架库
 *
 */
+ (JKSecurityWrapperResult *)encryptString:(NSString *)string publicKey:(NSString *)pubKey;
+ (JKSecurityWrapperResult *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
//
//+ (JKSecurityWrapperResult *)encryptString:(NSString *)string privateKey:(NSString *)privKey;
//+ (JKSecurityWrapperResult *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

#pragma mark RSA Decrypt
/**
 *  解密 公钥、私钥解密
 *
 */
+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 publicKey:(NSString *)pubKey;
+ (JKSecurityWrapperResult *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;

+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 privateKey:(NSString *)privKey;
+ (JKSecurityWrapperResult *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
@end
