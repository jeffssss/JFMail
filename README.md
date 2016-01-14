# JFMail
A simple iOS SMTP client.

ARC version of [skpsmtpmessage](https://github.com/jetseven/skpsmtpmessage)

Thanks to [jetseven](https://github.com/jetseven), I learn a lot his skpsmtpmessage project.

Fixing probleams:
1. can't send mail in concurrent thread.
2. Chinese character encoding of attachment filename. 

Any probleam, please contact me or [issue](https://github.com/jeffssss/JFMail/issues).

## Use JFMail

copy files in `JFMail/lib/` into your own project.

After fixing problems above, you can use cocoaPods.

## Demo

1. open `JFMail.xcodeproj`
2. change `JFMail/ViewController.m`, use your own infomation and right SMTP server URL
	
		JFMailSender *mailSender = [[JFMailSender alloc] init];
		mailSender.fromEmail = @"example@163.com";
		mailSender.toEmail = @"example@qq.com";
		mailSender.relayHost = @"smtp.163.com";
		mailSender.requiresAuth = YES;
		mailSender.login = @"example@163.com";
		mailSender.pass = @"example";

3. run the project.