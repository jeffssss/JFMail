# JFMail
A simple iOS SMTP client.

ARC version of [skpsmtpmessage](https://github.com/jetseven/skpsmtpmessage)

Thanks to [jetseven](https://github.com/jetseven), I learn a lot his skpsmtpmessage project.

Fixied probleams:

1. Can't send mail in concurrent thread.
2. Chinese character encoding of attachment filename. 

new feature:

1. A more friendly way to create `Part` NSDictionary.
2. You can edit fromEmail username by setting property `fromName`. 

Any probleam, please [issue](https://github.com/jeffssss/JFMail/issues). I will reply as soon as possible.

## Use JFMail

copy files in `JFMail/lib/` into your own project.

After fixing problems above and testing , you can use cocoaPods.

## Demo

1. open `JFMail.xcodeproj`
2. change `JFMail/ViewController.m`, edit your email infomation and the right SMTP server URL
	
		JFMailSender *mailSender = [[JFMailSender alloc] init];
		mailSender.fromEmail = @"example@163.com";
		mailSender.toEmail = @"example@qq.com";
		mailSender.relayHost = @"smtp.163.com";
		mailSender.requiresAuth = YES;
		mailSender.login = @"example@163.com";
		mailSender.pass = @"example";

3. run the project.