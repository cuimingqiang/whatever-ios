//
//  RegisterController.m
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "RegisterController.h"
#import "UIColor+Category.h"
#import "UIImage+Color.h"
#import "Masonry/Masonry.h"
#import "ReactiveCocoa.h"
#import "ValidateCodeVM.h"
@interface RegisterController()
@property(nonatomic)UITextField *tfAccount;
@property(nonatomic)UITextField *tfCode;
@property(nonatomic)UIButton    *btnCode;
@property(nonatomic)UIButton    *btnLogin;

@property(nonatomic)ValidateCodeVM *vm;
@end

@implementation RegisterController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"注册";
    
    _tfAccount = [[UITextField alloc]init];
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _tfAccount.backgroundColor = [UIColor whiteColor];
    _tfAccount.leftView = left;
    _tfAccount.leftViewMode = UITextFieldViewModeAlways;
    _tfAccount.placeholder = @"账号";
    [self.view addSubview:_tfAccount];
    [_tfAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(74));
        make.width.equalTo(self.view);
        make.height.equalTo(@(40));
        
    }];
    
    _tfCode = [[UITextField alloc]init];
    _tfCode.backgroundColor = [UIColor whiteColor];
    UIView *left1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _tfCode.leftView = left1;
    _tfCode.leftViewMode = UITextFieldViewModeAlways;
    _tfCode.placeholder = @"验证码";
    [self.view addSubview:_tfCode];
    [_tfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfAccount.mas_bottom).offset(10);
        make.width.equalTo(self.view);
        make.height.equalTo(_tfAccount.mas_height);
    }];
    
    _btnCode = [[UIButton alloc]init];
    _btnCode.backgroundColor = [UIColor colorWithString:@"#E0E0E0"];
    [_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:_btnCode];
    [_btnCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(_tfCode);
        make.trailing.equalTo(self.view);
        make.width.equalTo(@(110));
    }];
    
    _btnLogin = [[UIButton alloc]init];
    _btnLogin.backgroundColor = [UIColor colorWithString:@"8BC34A"];
    [_btnLogin setTitle:@"验证" forState:UIControlStateNormal];
    [self.view addSubview:_btnLogin];
    [_btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfCode.mas_bottom).offset(10);
        make.height.equalTo(_tfCode);
        make.leading.equalTo(@(10));
        make.trailing.equalTo(@(-10));
    }];
    
    [self bindVM];
}

-(void)bindVM{
    _vm = [[ValidateCodeVM alloc]init];
    RAC(self.vm.model,phone) = _tfAccount.rac_textSignal;
    RAC(self.vm.model,code) = _tfCode.rac_textSignal;
    
    RAC(_btnCode,enabled) = self.vm.getCodeEnableSignal;
    RAC(_btnLogin,enabled) = self.vm.validateEnableSignal;
    
    [self.vm.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"----------executionSignals:%@",x);
    }];
    
    [[self.vm.getCodeCommand.executing skip:1]subscribeNext:^(id x) {
        NSLog(@"----------executing:%@",x);
    }];
    
    [[_btnCode rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self.vm.getCodeCommand execute:nil];
    }];
    
    [[_btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.vm.validateCommand execute:nil];
    }];
}
@end
