//
//  ViewController.m
//  ZhiFuBaoDemo
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//


#import "ViewController.h"
#import "AFNetworking.h"
#import <AlipaySDK/AlipaySDK.h>

#define HTTPHANDER @"http://jrj.ecio.cc"

@interface ViewController ()
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(100, 100, 200, 50);
    [button addTarget:self action:@selector(ComitButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    button.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button];
    
}
-(void)ComitButtonClick:(UIButton *)button{

    
    if (self.manager) {
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/API/Alipay/Client_Deposit",HTTPHANDER];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"111111" forKey:@"ClientKey"];
    [dict setObject:@"664" forKey:@"Payer"];
    [dict setObject:@"0.01" forKey:@"Amount"];
    [dict setObject:@"account" forKey:@"Type"];
    [dict setObject:@"635954709463722732" forKey:@"_t"];
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager POST:urlStr parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self Cancel];
        if ([dic[@"resultStatus"] intValue] == 0) {
            NSLog(@"客户端充值签名参数:%@",dic[@"data"][@"ClientPARM"]);
            if (dic[@"data"][@"ClientPARM"] != nil) {
                NSString *appScheme = @"ZHIFUBAODEMODEMO";
               [ [AlipaySDK defaultService] payOrder:dic[@"data"][@"ClientPARM"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                   NSLog(@"result111:%@",resultDic);
                }];
                }
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChengGongAction:) name:@"chongzhichenggonghuidiao" object:nil];
        }else{
            NSLog(@"失败了");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错了");
        [self Cancel];
    }];
    
}
-(void)ChengGongAction:(NSNotification *)not{
    NSLog(@"44444:%@",not.object);
    if (self.manager) {
        return;
    }
    //替换掉特殊符号 例如：+
    NSString *ResultString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (CFStringRef)[NSString stringWithFormat:@"%@",not.object[@"result"]],
                                                                                         NULL,
                                                                                         CFSTR(":/?#[]@!$&’()*+,;="),
                                                                                         kCFStringEncodingUTF8);

    NSString *ResultStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",not.object[@"result"]], nil, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));

    NSString *urlStr = [NSString stringWithFormat:@"%@/API/Alipay/Client_CheckSign",HTTPHANDER];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"111111" forKey:@"ClientKey"];
    [dict setObject:[NSString stringWithFormat:@"%@",not.object[@"memo"]] forKey:@"memo"];
    [dict setObject:[NSString stringWithFormat:@"%@",not.object[@"result"]] forKey:@"Result"];
    [dict setObject:[NSString stringWithFormat:@"%@",not.object[@"resultStatus"]] forKey:@"resultStatus"];

//    [dict setObject:@"635954709463722732" forKey:@"_t"];
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager POST:urlStr parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self Cancel];
        if ([dic[@"resultStatus"] intValue] == 0) {
            NSLog(@"客户端充值签名参数:%@",@"chenggong");
            
        }else{
            NSLog(@"失败了");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错了");
        [self Cancel];
    }];
    

}
-(void)Cancel{
    self.manager = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
