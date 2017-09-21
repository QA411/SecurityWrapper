//
//  JKSecurityAESWrapper.m
//  Pods
//
//  Created by Futao on 16/4/13.
//
//

#import "JKSecurityAESWrapper.h"
#import "JKSecurityWrapper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation JKSecurityAESWrapper

#pragma mark - AES Encrypt
// default AES Encrypt, key -> SHA384(key).sub(0, 32), iv -> SHA384(key).sub(32, 16)
+ (JKSecurityWrapperResult *)encryptString:(NSString *)string key:(NSString *)key
{
    JKSecurityWrapperResult * sha = [JKSecurityWrapper sha384:key];
    NSData *aesKey = [sha.data subdataWithRange:NSMakeRange(0, 32)];
    NSData *aesIv = [sha.data subdataWithRange:NSMakeRange(32, 16)];
    
    return [self encryptString:string key:aesKey iv:aesIv];
}
#pragma mark AES Encrypt 128, 192, 256
+ (JKSecurityWrapperResult *)encryptString:(NSString *)string hexKey:(NSString *)key hexIv:(NSString *)iv
{
    JKSecurityWrapperDecoder *decoder = [JKSecurityWrapperDecoder new];
    NSData *aesKey = [decoder hex:key];
    NSData *aesIv = [decoder hex:iv];
    
    return [self encryptString:string key:aesKey iv:aesIv];
}
+ (JKSecurityWrapperResult *)encryptString:(NSString *)string key:(NSData *)key iv:(NSData *)iv
{
    return [self encryptData:[string dataUsingEncoding:NSUTF8StringEncoding] key:key iv:iv];
}
+ (JKSecurityWrapperResult *)encryptData:(NSData *)data key:(NSData *)key iv:(NSData *)iv
{
    // check length of key and iv
    if ([iv length] != 16) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of iv is wrong. Length of iv should be 16(128bits)"
                                     userInfo:nil];
    }
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)"
                                     userInfo:nil];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [key bytes],     // Key
                                          [key length],    // kCCKeySizeAES
                                          [iv bytes],       // IV
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        JKSecurityWrapperResult *result = [[JKSecurityWrapperResult alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        
        return result;
    }
    else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Encrypt Error!"
                                     userInfo:nil];
        return nil;
    }
}
#pragma mark - AES Decrypt
// default AES Decrypt, key -> SHA384(key).sub(0, 32), iv -> SHA384(key).sub(32, 16)
+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 key:(NSString *)key
{
    JKSecurityWrapperResult * sha = [JKSecurityWrapper sha384:key];
    NSData *aesKey = [sha.data subdataWithRange:NSMakeRange(0, 32)];
    NSData *aesIv = [sha.data subdataWithRange:NSMakeRange(32, 16)];
    
    return [self decryptBase64:base64 key:aesKey iv:aesIv];
}
#pragma mark AES Decrypt 128, 192, 256
+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 hexKey:(NSString *)key hexIv:(NSString *)iv
{
    JKSecurityWrapperDecoder *decoder = [JKSecurityWrapperDecoder new];
    NSData *aesKey = [decoder hex:key];
    NSData *aesIv = [decoder hex:iv];
    
    return [self decryptBase64:base64 key:aesKey iv:aesIv];
}
+ (JKSecurityWrapperResult *)decryptBase64:(NSString *)base64 key:(NSData *)key iv:(NSData *)iv
{
    JKSecurityWrapperDecoder *decoder = [JKSecurityWrapperDecoder new];
    return [self decryptData:[decoder base64:base64] key:key iv:iv];
}
+ (JKSecurityWrapperResult *)decryptData:(NSData *)data key:(NSData *)key iv:(NSData *)iv
{
    // check length of key and iv
    if ([iv length] != 16) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of iv is wrong. Length of iv should be 16(128bits)"
                                     userInfo:nil];
    }
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)"
                                     userInfo:nil];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [key bytes],     // Key
                                          [key length],    // kCCKeySizeAES
                                          [iv bytes],       // IV
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        JKSecurityWrapperResult *result = [[JKSecurityWrapperResult alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        
        return result;
    }
    else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Decrypt Error!"
                                     userInfo:nil];
        return nil;
    }
}


@end
