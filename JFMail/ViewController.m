//
//  ViewController.m
//  JFMail
//
//  Created by JiFeng on 16/1/13.
//  Copyright © 2016年 jeffsss. All rights reserved.
//

#import "ViewController.h"
#import "JFMailSender.h"

@interface ViewController ()<JFMailSenderDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load");
    
    JFMailSender *mailSender = [[JFMailSender alloc] init];
    mailSender.fromEmail = @"example@163.com";
    mailSender.toEmail = @"example@qq.com";
    mailSender.relayHost = @"smtp.163.com";
    mailSender.requiresAuth = YES;
    mailSender.login = @"example@163.com";
    mailSender.pass = @"example";
    mailSender.wantsSecure = NO;
    
    mailSender.subject = @"JF测试用邮件";
    mailSender.delegate = self;
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain; charset=UTF-8",smtpPartContentTypeKey,
                               @"ceshiceshiceshi 测试测试测试.",smtpPartMessageKey,@"8bit",smtpPartContentTransferEncodingKey,nil];
    
    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",smtpPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"test.vcf\"",smtpPartContentDispositionKey,[vcfData base64EncodedStringWithOptions:0],smtpPartMessageKey,@"base64",smtpPartContentTransferEncodingKey,nil];
    
    mailSender.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [mailSender sendMail];
    });

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailSent:(JFMailSender *)message
{
    NSLog(@"Yay! Message was sent!");
}

- (void)mailFailed:(JFMailSender *)message error:(NSError *)error
{
    NSLog(@"%@", [NSString stringWithFormat:@"Darn! Error!\n%i: %@\n%@", [error code], [error localizedDescription], [error localizedRecoverySuggestion]]);
}

@end
