//
//  MyAlert.m
//  MyAlertView
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define KscreenHeigh           [[UIScreen mainScreen] bounds].size.height
#define KscreenWidth           [[UIScreen mainScreen] bounds].size.width
#define fontBlackColor RGBCOLOR(51, 51, 51)
#define fontGreyColor RGBCOLOR(153,153,153)
#define Bg_Grey RGBCOLOR(238, 238, 238)

#import "MyAlert.h"
#import "Masonry.h"
@implementation MyAlert

- (instancetype)initWithFrame:(CGRect)rect
{
    self = [super init];
    if (self) {
        self.bgShowView = [[UIView alloc]init];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _bgShowView.frame = [UIScreen mainScreen].bounds;
        _bgShowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [window addSubview:_bgShowView];
        
        
        view = [[UIView alloc] initWithFrame:CGRectMake(60, (KscreenHeigh - 200) / 2, KscreenWidth - 120, 150)];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 1;
        view.layer.cornerRadius = 6;
        view.layer.masksToBounds = YES;
        [_bgShowView addSubview:view];
        }
    return self;
}
-(void)CreateAlertWithTitle:(NSString *)titleLab WithContent:(NSString *)contentLab WithType:(AlertViewType)type{
    
    
    UILabel * _titleLable = [[UILabel alloc] init];
    _titleLable.text = titleLab;
    _titleLable.font = [UIFont systemFontOfSize:17];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.textColor = RGBCOLOR(173, 173, 173);
    [view addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@24);
        make.centerX.equalTo(view.mas_centerX);
    }];
    
    UILabel * _contentLabel = [[UILabel alloc] init];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.text = contentLab;
    _contentLabel.textColor = fontBlackColor;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_bottom).offset(17);
        make.centerX.equalTo(view.mas_centerX);
    }];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, view.frame.size.height - 50, view.frame.size.width / 2, 50);
    [_cancelBtn setTitle:@"否" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_cancelBtn setTitleColor:fontBlackColor forState:UIControlStateNormal];
    [view addSubview:_cancelBtn];
    
    _goToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _goToBtn.frame = CGRectMake(view.frame.size.width / 2, view.frame.size.height - 50, view.frame.size.width / 2, 50);
    [_goToBtn setTitle:@"是" forState:UIControlStateNormal];
    _goToBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_goToBtn setTitleColor:RGBCOLOR(255, 51, 51) forState:(UIControlStateNormal)];
    [_goToBtn addTarget:self action:@selector(goToBtnAction) forControlEvents:(UIControlEventTouchUpInside)];

    [view addSubview:_goToBtn];
    
    
    UIView *lineViewH = [[UIView alloc]init];
    lineViewH.backgroundColor = Bg_Grey;
    [view addSubview:lineViewH];
    [lineViewH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.top.equalTo(_cancelBtn.mas_top);
    }];
    
    UIView *lineViewV = [[UIView alloc]init];
    lineViewV.backgroundColor = Bg_Grey;
    [view addSubview:lineViewV];
    [lineViewV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineViewH.mas_bottom);
        make.width.equalTo(@0.5);
        make.bottom.equalTo(@0);
        make.centerX.equalTo(view.mas_centerX);
    }];

    
}
-(void)cancelBtnAction{
    if ([_delegate respondsToSelector:@selector(AlertButtonClick:)]) {
        [_delegate AlertButtonClick:@"NO"];
    }
    [self.bgShowView removeFromSuperview];
    self.bgShowView = nil;
}
-(void)goToBtnAction{
    if ([_delegate respondsToSelector:@selector(AlertButtonClick:)]) {
        [_delegate AlertButtonClick:@"YES"];
    }
    [self.bgShowView removeFromSuperview];
    self.bgShowView = nil;
}

@end
