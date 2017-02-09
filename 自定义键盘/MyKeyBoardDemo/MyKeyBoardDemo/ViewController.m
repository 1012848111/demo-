//
//  ViewController.m
//  MyKeyBoardDemo
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "My_KeyBoardView.h"
@interface ViewController ()<My_KeyBoardDelegate,UITextFieldDelegate>
@property (nonatomic, strong) My_KeyBoardView *my_keyboard;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 168, kScreenWidth - 100, 50)];
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor greenColor];
    self.textField.placeholder = @"(默认系统键盘)";
    
    [self.view addSubview:self.textField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    [self keyBoardTypeAction];
}
- (void)keyBoardTypeAction
{

        self.my_keyboard = [[My_KeyBoardView alloc] initWithNumber:@1];
        self.textField.inputView = self.my_keyboard;
        self.my_keyboard.delegate = self;
        [self.textField reloadInputViews];
}
- (void)hidenKeyBoard
{
    NSLog(@"键盘隐藏");
    [self.textField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"显示键盘");
}

- (void)numberKeyBoard:(NSInteger)number
{
    NSString *str = self.textField.text;
    self.textField.text = [NSString stringWithFormat:@"%@%ld",str,(long)number];
}

- (void)cancelKeyBoard
{
    
    NSMutableString *muStr = [[NSMutableString alloc] initWithString:self.textField.text];
    if (muStr.length <= 0) {
        return;
    }
    [muStr deleteCharactersInRange:NSMakeRange([muStr length] - 1, 1)];
    self.textField.text = muStr;
}

#pragma 输入点
-(void)periodKeyBoard{
    
    if ([self.textField.text isEqualToString:@""]) {
        return;
    }
    
    //判断当前时候存在一个点
    if ([self.textField.text rangeOfString:@"."].location == NSNotFound) {
        //输入中没有点
        NSMutableString  *mutableString=[[NSMutableString alloc]initWithFormat:@"%@%@",self.textField.text,@"."];
        self.textField.text=mutableString;
    }
}
-(void)changeKeyBoard{
    self.textField.inputView = nil;
    [self.textField reloadInputViews];
}

-(void)finishKeyBoard{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
