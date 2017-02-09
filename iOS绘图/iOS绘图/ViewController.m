//
//  ViewController.m
//  iOS绘图
//
//  Created by mac on 16/10/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()
@property(nonatomic,strong)UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    MyView * view = [[MyView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.textView];
    
    [self setupTextView];
}
- (void)setupTextView
{
    // 富文本技术：
    // 1.图文混排
    // 2.随意修改文字样式
    //    self.textView.text = @"哈哈4365746875";
    //    self.textView.textColor = [UIColor blueColor];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"哈哈123456"];
    // 设置“哈哈”为蓝色
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
    [string addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    
    // 设置“456”为红色
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 2)];
    [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(6, 2)];
    [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(6, 2)];
    
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"1.jpg"];
    attach.bounds = CGRectMake(0, 0, 45, 15);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    
    [string appendAttributedString:attachString];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"789"]];
    
    self.textView.attributedText = string;
    
    /**
     iOS 6之前：CoreText,纯C语言,极其蛋疼
     iOS 6开始：NSAttributedString,简单易用
     iOS 7开始：TextKit,功能强大,简单易用
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
