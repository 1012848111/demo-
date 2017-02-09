//
//  ViewController.m
//  MyAlertView
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "MyAlert.h"

@interface ViewController ()<MyAlertViewDelegate>
{
    MyAlert * alert;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)dianji:(id)sender {
    alert = [[MyAlert alloc]initWithFrame:CGRectZero];
    [alert CreateAlertWithTitle:@"请认证名片" WithContent:@"是否认证您的名片？" WithType:(AlertViewType_Two)];
    alert.delegate = self;
}

-(void)AlertButtonClick:(NSString *)msg
{
    if ([msg isEqualToString:@"YES"]) {
        NSLog(@"yes");
        
    }
    alert = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
