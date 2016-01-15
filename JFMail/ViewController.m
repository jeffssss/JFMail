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
    
    mailSender.fromName = @"积分";
    mailSender.subject = @"JF测试用邮件";
    mailSender.delegate = self;
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain; charset=UTF-8",smtpPartContentTypeKey,
                               @"ceshiceshiceshi 测试测试测试.",smtpPartMessageKey,@"8bit",smtpPartContentTransferEncodingKey,nil];
    
    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",smtpPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"test.vcf\"",smtpPartContentDispositionKey,[vcfData base64EncodedStringWithOptions:0],smtpPartMessageKey,@"base64",smtpPartContentTransferEncodingKey,nil];
    
    NSString *fileName = [JFMailSender chineseCharacterEncodingFileNameWithFileName:@"测试.vcf"];
    //the other ways to create Part Dictionary.
    NSDictionary *vcfPart2 = [JFMailSender partWithType:PartTypeFilePart
                                                Message:[vcfData base64EncodedStringWithOptions:0]
                                            ContentType:[NSString stringWithFormat:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"%@\"",fileName]
                                ContentTransferEncoding:@"base64"
                                               FileName:fileName];
    
    mailSender.parts = [NSArray arrayWithObjects:plainPart,vcfPart,vcfPart2,nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    dispatch_async(dispatch_get_main_queue(), ^{
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
    //if something must run in main thread,please use dispatch_get_main_queue();
    NSLog(@"Yay! Message was sent!");
}

- (void)mailFailed:(JFMailSender *)message error:(NSError *)error
{
    //if something must run in main thread,please use dispatch_get_main_queue();
    NSLog(@"%@", [NSString stringWithFormat:@"Darn! Error!\n%i: %@\n%@", [error code], [error localizedDescription], [error localizedRecoverySuggestion]]);
}

@end
