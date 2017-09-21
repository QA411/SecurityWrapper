//
//  JKSecurityWrapperResult.m
//  Pods
//
//  Created by Futao on 16/4/13.
//
//

#import "JKSecurityWrapperResult.h"

#pragma mark - JKSecurityWrapperResult
@implementation JKSecurityWrapperResult

@synthesize data = _data;

#pragma mark - Init
- (id)initWithBytes:(unsigned char[])initData length:(NSUInteger)length
{
    self = [super init];
    if (self) {
        _data = [NSData dataWithBytes:initData length:length];
    }
    return self;
}
- (id)initWithData:(NSData*)data {
    self = [super init];
    if (self) {
        _data = [NSData dataWithData:data];
    }
    return self;
}

#pragma mark UTF8 String
// convert JKSecurityWrapperResult to UTF8 string
- (NSString *)utf8String
{
    NSString *result = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    return result;
}

#pragma mark HEX
// convert JKSecurityWrapperResult to HEX string
- (NSString *)hex
{
    JKSecurityWrapperEncoder *encoder = [JKSecurityWrapperEncoder new];
    return [encoder hex:_data useLower:false];
}
- (NSString *)hexLower
{
    JKSecurityWrapperEncoder *encoder = [JKSecurityWrapperEncoder new];
    return [encoder hex:_data useLower:true];
}

#pragma mark Base64
// convert JKSecurityWrapperResult to Base64 string
- (NSString *)base64
{
    JKSecurityWrapperEncoder *encoder = [JKSecurityWrapperEncoder new];
    return [encoder base64:_data];
}

- (NSString*)description
{
    NSString *description = [NSString stringWithFormat:@"\nutf8String: %@\nhex: %@\nhexLower: %@\nbase64: %@",[self utf8String],[self hex],[self hexLower],[self base64]];
    return description;
}
@end


#pragma mark - JKSecurityWrapperEncoder
@implementation JKSecurityWrapperEncoder

// convert NSData to Base64
- (NSString *)base64:(NSData *)data
{
    return [data base64EncodedStringWithOptions:0];
}

// convert NSData to hex string
- (NSString *)hex:(NSData *)data useLower:(BOOL)isOutputLower
{
    if (data.length == 0) { return nil; }
    
    static const char HexEncodeCharsLower[] = "0123456789abcdef";
    static const char HexEncodeChars[] = "0123456789ABCDEF";
    char *resultData;
    // malloc result data
    resultData = malloc([data length] * 2 +1);
    // convert imgData(NSData) to char[]
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    NSUInteger length = [data length];
    
    if (isOutputLower) {
        for (NSUInteger index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    }
    else {
        for (NSUInteger index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    
    // convert result(char[]) to NSString
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    
    return result;
}

@end

#pragma mark - JKSecurityWrapperDecoder
@implementation JKSecurityWrapperDecoder
- (NSData *)base64:(NSString *)string
{
    return [[NSData alloc] initWithBase64EncodedString:string options:0];
}
- (NSData *)hex:(NSString *)data
{
    if (data.length == 0) { return nil; }
    
    static const unsigned char HexDecodeChars[] =
    {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, //49
        2, 3, 4, 5, 6, 7, 8, 9, 0, 0, //59
        0, 0, 0, 0, 0, 10, 11, 12, 13, 14,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //79
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 10, 11, 12,   //99
        13, 14, 15
    };
    
    // convert data(NSString) to CString
    const char *source = [data cStringUsingEncoding:NSUTF8StringEncoding];
    // malloc buffer
    unsigned char *buffer;
    NSUInteger length = strlen(source) / 2;
    buffer = malloc(length);
    for (NSUInteger index = 0; index < length; index++) {
        buffer[index] = (HexDecodeChars[source[index * 2]] << 4) + (HexDecodeChars[source[index * 2 + 1]]);
    }
    // init result NSData
    NSData *result = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    source = nil;
    
    return  result;
}

@end