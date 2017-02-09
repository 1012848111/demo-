//
//  My_KeyBoardView.m
//  MyKeyBoardDemo
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "My_KeyBoardView.h"
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@implementation My_KeyBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithNumber:(NSNumber *)number;
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake(0, kScreenHeight - 150, kScreenHeight, 150);
        
            [self initKeyBoardNumber_1];
    }
    return self;
}


- (void)initKeyBoardNumber_1
{
    self.frame=CGRectMake(0, kScreenHeight-243, kScreenWidth, 243);
    int space=1;
    for (int i=0; i<9; i++) {
        NSString *str=[NSString stringWithFormat:@"%d",i+1];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        if (i<3) {
            button.frame=CGRectMake(i%3*(kScreenWidth/4)+space, i/3*61, kScreenWidth/4-1, 60);
        }
        else{
            button.frame=CGRectMake(i%3*(kScreenWidth/4)+space, i/3*60+i/3*space, kScreenWidth/4-1, 60);
        }
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:24];
        [button setTitle:str forState:UIControlStateNormal];
        button.tag=i+1;
        [button addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIButton *dian=[UIButton buttonWithType:UIButtonTypeSystem];
    dian.frame=CGRectMake(space,60*3+3 , kScreenWidth/4-1, 60);
    dian.backgroundColor=[UIColor whiteColor];
    [dian setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dian.titleLabel.font=[UIFont systemFontOfSize:24];
    [dian addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    [dian setTitle:@"." forState:UIControlStateNormal];
    dian.tag=11;
    [self addSubview:dian];
    UIButton *ling=[UIButton buttonWithType:UIButtonTypeSystem];
    ling.frame=CGRectMake(kScreenWidth/4+1*space,60*3+3, kScreenWidth/4-1, 60);
    ling.backgroundColor=[UIColor whiteColor];
    [ling setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ling.titleLabel.font=[UIFont systemFontOfSize:24];
    [ling setTitle:@"0" forState:UIControlStateNormal];
    ling.tag=0;
    [ling addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ling];
    
    UIButton *computer=[UIButton buttonWithType:UIButtonTypeSystem];
    computer.frame=CGRectMake(kScreenWidth/4*2+space,60*3+3, kScreenWidth/4-1, 60);
    computer.backgroundColor=[UIColor whiteColor];
    [computer setTitle:@"系统键盘" forState:UIControlStateNormal];
    computer.tag=12;
    [computer addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:computer];
    
    UIButton *delete=[UIButton buttonWithType:UIButtonTypeSystem];
    delete.frame=CGRectMake(kScreenWidth/4*3+space,1, kScreenWidth/4-1, 122);
    [delete addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    delete.tag=10;
    
    UIImageView *deleteImage=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/4-1 - 28) * 1.0 / 2, 50, 28, 20)];
    deleteImage.image=[UIImage imageNamed:@"goumai_03"];
    [delete addSubview:deleteImage];
    
    // [delete setBackgroundImage:[UIImage imageNamed:@"goumai_03"] forState:UIControlStateNormal];
    [self addSubview:delete];
    
    UIButton *confirm=[UIButton buttonWithType:UIButtonTypeSystem];
    confirm.frame=CGRectMake(kScreenWidth/4*3+space,61*2, kScreenWidth/4-1, 122);
    confirm.backgroundColor=[UIColor blueColor];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:20];
    [confirm setTitle:@"确 定" forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    confirm.tag=13;
    [self addSubview:confirm];
}

#pragma 键盘点击按钮事件
- (void)keyBoardAciont:(UIButton *)sender
{
    
    UIButton* btn = (UIButton*)sender;
    
    NSInteger number = btn.tag;
    
    // no delegate, print log info
    if (nil == _delegate) {
        NSLog(@"button tag [%ld]",(long)number);
        return;
    }
    
    if (number <= 9 && number >= 0) {
        [_delegate numberKeyBoard:number];
        return;
    }
    
    if (10 == number) {
        [_delegate cancelKeyBoard];
        return;
    }
    if (11 == number) {
        [_delegate periodKeyBoard];
        return;
    }
    if (12 == number) {
        [_delegate changeKeyBoard];
        return;
    }
    
    if (13 == number) {
        [_delegate finishKeyBoard];
        return;
    }
    
}
@end
