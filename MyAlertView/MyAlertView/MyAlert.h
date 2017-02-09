//
//  MyAlert.h
//  MyAlertView
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    AlertViewType_One,
    AlertViewType_Two,
    AlertViewType_Field,
}AlertViewType;

@protocol MyAlertViewDelegate <NSObject>

-(void)AlertButtonClick:(NSString *)msg;

@end

@interface MyAlert : NSObject
{
    UIView *view;
}
@property(nonatomic,assign)id<MyAlertViewDelegate> delegate;
@property(nonatomic,strong)UIView *bgShowView;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *goToBtn;

-(instancetype)initWithFrame:(CGRect)rect;
-(void)CreateAlertWithTitle:(NSString *)titleLab WithContent:(NSString *)contentLab WithType:(AlertViewType)type;

@end
