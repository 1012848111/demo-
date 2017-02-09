//
//  My_KeyBoardView.h
//  MyKeyBoardDemo
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建自定义键盘协议
@protocol My_KeyBoardDelegate <NSObject>
//创建协议方法
@required//必须执行的方法
- (void)numberKeyBoard:(NSInteger) number;
- (void)cancelKeyBoard;
- (void)finishKeyBoard;
- (void)periodKeyBoard;
- (void)changeKeyBoard;
@optional//不必须执行方法

@end

@interface My_KeyBoardView : UIView
{
@private//私有的协议方法
    id<My_KeyBoardDelegate> _delegate;
}
@property (nonatomic, strong) id<My_KeyBoardDelegate> delegate;

- (id)initWithNumber:(NSNumber *)number;
@end
