//
//  RegisterController.m
//  whatever
//
//  Created by cuimingqiang on 16/5/31.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "RegisterController.h"
#import "CommonHeader.h"
#import "RegisterVM.h"
@interface RegisterController ()
@property(nonatomic)UITextField *nickname;
@property(nonatomic)UITextField *password;
@property(nonatomic)UIButton    *ok;

@property(nonatomic)RegisterVM *vm;
@end

@implementation RegisterController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"账号信息";
    
    _nickname = [[UITextField alloc]init];
    _nickname.backgroundColor = [UIColor whiteColor];
    _nickname.placeholder = @"用户昵称";
    _nickname.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _nickname.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nickname];
    [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(74));
        make.width.equalTo(self.view);
        make.height.equalTo(@(40));
    }];
    
    _password = [[UITextField alloc]init];
    _password.backgroundColor = [UIColor whiteColor];
    _password.placeholder = @"密码";
    _password.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _password.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickname.mas_bottom).offset(10);
        make.width.equalTo(self.view);
        make.height.equalTo(@(40));
    }];
    
    _ok = [[UIButton alloc]init];
    _ok.backgroundColor = [UIColor colorWithString:@"8BC34A"];
    [_ok setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_ok];
    [_ok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_password.mas_bottom).offset(10);
        make.trailing.equalTo(@(-10));
        make.leading.equalTo(@(10));
        make.height.equalTo(@(40));
    }];
    [self bindVM];
}

-(void)bindVM{
    _vm = [[RegisterVM alloc]init];
    _vm.model.registerToken = _registerToken;
    _vm.model.phone = _phone;
    RAC(self.vm.model,nickname) = _nickname.rac_textSignal;
    RAC(self.vm.model,password) = _password.rac_textSignal;
    
    [[_nickname rac_textSignal]subscribeNext:^(id x) {
        if([x length] > 12)[_nickname setText:[x substringToIndex:12]];
    }];
    //注册
    [[_ok rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[self.vm.registerCommand execute:nil]subscribeNext:^(id x) {
            [MBProgressHUD hideWithSuccessAndMsg:@"注册成功" inView:self.view];
        } error:^(NSError *error) {
            [MBProgressHUD hideWithSuccessAndMsg:error.localizedDescription inView:self.view];
        }];
    }];
}
@end
