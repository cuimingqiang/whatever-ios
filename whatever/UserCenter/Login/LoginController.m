//
//  LoginController.m
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "LoginController.h"
#import "CommonHeader.h"
#import "ValidatePhoneController.h"
@interface LoginController()
@property(nonatomic)UITextField *phone;
@property(nonatomic)UITextField *password;
@property(nonatomic)UIButton *btnLogin;

@property(nonatomic)UIButton *btnForgot;
@property(nonatomic)UIButton *btnRegister;
@end

@implementation LoginController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"登录";
   
    _phone = [[UITextField alloc]init];
    _phone.backgroundColor = [UIColor whiteColor];
    _phone.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _phone.leftViewMode = UITextFieldViewModeAlways;
    _phone.placeholder = @"手机号";
    [self.view addSubview:_phone];
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(74));
        make.width.equalTo(self.view);
        make.height.equalTo(@(40));
    }];
    
    _password = [[UITextField alloc]init];
    _password.backgroundColor = [UIColor whiteColor];
    _password.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.placeholder = @"密码";
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phone.mas_bottom).offset(10);
        make.width.equalTo(self.view);
        make.height.equalTo(@(40));
    }];
    
    _btnLogin = [[UIButton alloc]init];
    _btnLogin.backgroundColor = [UIColor colorWithString:@"8BC34A"];
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:_btnLogin];
    [_btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_password.mas_bottom).offset(10);
        make.leading.equalTo(@(10));
        make.trailing.equalTo(@(-10));
        make.height.equalTo(@(40));
    }];
    
    _btnRegister = [[UIButton alloc]init];
    [_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [_btnRegister setTitleColor:[UIColor colorWithString:@"1E90FF"] forState:UIControlStateNormal];
    [_btnRegister setTitleColor:[UIColor colorWithString:@"5CACEE"] forState:UIControlStateHighlighted];
    [self.view addSubview:_btnRegister];
    [_btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnLogin.mas_bottom).offset(10);
        make.leading.equalTo(@(10));
    }];
    
    _btnForgot = [[UIButton alloc]init];
    [_btnForgot setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_btnForgot setTitleColor:[UIColor colorWithString:@"1E90FF"] forState:UIControlStateNormal];
    [_btnForgot setTitleColor:[UIColor colorWithString:@"5CACEE"] forState:UIControlStateHighlighted];
    [self.view addSubview:_btnForgot];
    [_btnForgot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnLogin.mas_bottom).offset(10);
        make.trailing.equalTo(@(-10));
    }];
    
    [self bindVM];
}
-(void)bindVM{
    [[_btnRegister rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        UINavigationController *vc =  [[UINavigationController alloc]initWithRootViewController:[[ValidatePhoneController alloc]init]];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}
@end
