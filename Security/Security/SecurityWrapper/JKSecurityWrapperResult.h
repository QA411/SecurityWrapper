//
//  JKSecurityWrapperResult.h
//  Pods
//
//  Created by Futao on 16/4/13.
//
//

#import <Foundation/Foundation.h>

#pragma mark - JKSecurityWrapperResult
@interface JKSecurityWrapperResult : NSObject

@property (strong, nonatomic, readonly) NSData *data;
@property (strong, nonatomic, readonly) NSString *utf8String;
@property (strong, nonatomic, readonly) NSString *hex;
@property (strong, nonatomic, readonly) NSString *hexLower;
@property (strong, nonatomic, readonly) NSString *base64;

- (id)initWithBytes:(unsigned char[])initData length:(NSUInteger)length;
- (id)initWithData:(NSData*)data;

@end


#pragma mark - JKSecurityWrapperEncoder
@interface JKSecurityWrapperEncoder : NSObject
- (NSString *)base64:(NSData *)data;
- (NSString *)hex:(NSData *)data useLower:(BOOL)isOutputLower;
@end


#pragma mark - JKSecurityWrapperDecoder
@interface JKSecurityWrapperDecoder : NSObject
- (NSData *)base64:(NSString *)data;
- (NSData *)hex:(NSString *)data;
@end