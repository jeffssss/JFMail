//
//  JFMailSender.h
//  JFMail
//
//  Created by JiFeng on 16/1/13.
//  Copyright © 2016年 jeffsss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>

enum{
    smtpIdle = 0,
    smtpConnecting,
    smtpWaitingEHLOReply,
    smtpWaitingTLSReply,
    smtpWaitingLOGINUsernameReply,
    smtpWaitingLOGINPasswordReply,
    smtpWaitingAuthSuccess,
    smtpWaitingFromReply,
    smtpWaitingToReply,
    smtpWaitingForEnterMail,
    smtpWaitingSendSuccess,
    smtpWaitingQuitReply,
    smtpMessageSent
};

typedef enum{
    PartTypeFilePart = 0,
    PartTypePlainPart
} PartType;

typedef NSUInteger SmtpState;
// Message part keys
extern NSString *smtpPartContentDispositionKey;
extern NSString *smtpPartContentTypeKey;
extern NSString *smtpPartMessageKey;
extern NSString *smtpPartContentTransferEncodingKey;

// Error message codes
#define smtpErrorConnectionTimeout -5
#define smtpErrorConnectionFailed -3
#define smtpErrorConnectionInterrupted -4
#define smtpErrorUnsupportedLogin -2
#define smtpErrorTLSFail -1
#define smtpErrorNonExistentDomain 1
#define smtpErrorInvalidUserPass 535
#define smtpErrorInvalidMessage 550
#define smtpErrorNoRelay 530


@class JFMailSender;

@protocol JFMailSenderDelegate
@required

-(void)mailSent:(JFMailSender *)message;
-(void)mailFailed:(JFMailSender *)message error:(NSError *)error;

@end

@interface JFMailSender : NSObject <NSCopying, NSStreamDelegate>

@property(nonatomic, assign) BOOL requiresAuth;
@property(nonatomic, copy) NSString *login;
@property(nonatomic, copy) NSString *pass;

@property(nonatomic, copy) NSString *relayHost;
@property(nonatomic, strong) NSArray *relayPorts;

@property(nonatomic, assign) BOOL wantsSecure;
@property(nonatomic, assign) BOOL validateSSLChain;

@property(nonatomic, copy) NSString *subject;
@property(nonatomic, copy) NSString *fromEmail;
@property(nonatomic, copy) NSString *toEmail;
@property(nonatomic, copy) NSString *ccEmail;
@property(nonatomic, copy) NSString *bccEmail;
@property(nonatomic, strong) NSArray *parts;

@property(nonatomic, assign) NSTimeInterval connectTimeout;

@property(nonatomic, assign) id <JFMailSenderDelegate> delegate;

- (BOOL)sendMail;

+ (NSDictionary *)partWithType:(PartType)type Message:(NSString *)message ContentType:(NSString *)contentType ContentTransferEncoding:(NSString *)contentTransferEncoding FileName:(NSString *)fileName;

//solve chinese character encoding problem on attachment filename
+ (NSString *)chineseCharacterEncodingFileNameWithFileName:(NSString *)fileName;

@end
