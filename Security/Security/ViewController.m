//
//  ViewController.m
//  Security
//
//  Created by qq on 2017/9/20.
//  Copyright © 2017年 fangxian. All rights reserved.
//

#import "ViewController.h"
#import "JKSecurity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"加密示例结果控制台打印";
    
    NSString *str = @"啦啦啦";
    //MARK: MD5使用类JKSecurityWrapper查看
    NSLog(@"MD5使用类JKSecurityWrapper查看，MD5==%@",[JKSecurityWrapper md5:str].hexLower);
    
    //MARK: AES加密、解密使用类JKSecurityAESWrapper查看
    NSLog(@"AES加密、解密使用类JKSecurityAESWrapper查看");
    
    //MARK: RSA加密、解密使用类JKSecurityRSAWrapper查看
    NSLog(@"RSA加密、解密使用类JKSecurityRSAWrapper查看");
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
