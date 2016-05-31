//
//  ValidatePhoneController.m
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "ValidatePhoneController.h"
#import "CommonHeader.h"
#import "ValidateCodeVM.h"
@interface ValidatePhoneController()
@property(nonatomic)UITextField *tfAccount;
@property(nonatomic)UITextField *tfCode;
@property(nonatomic)UIButton    *btnCode;
@property(nonatomic)UIButton    *btnLogin;

@property(nonatomic)ValidateCodeVM *vm;
@end

@implementation ValidatePhoneController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"验证手机号";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    _tfAccount = [[UITextField alloc]init];
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _tfAccount.backgroundColor = [UIColor whiteColor];
    _tfAccount.leftView = left;
    _tfAccount.keyboardType = UIKeyboardTypePhonePad;
    _tfAccount.leftViewMode = UITextFieldViewModeAlways;
    _tfAccount.placeholder = @"手机号";
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
    
    [[_tfAccount rac_textSignal]subscribeNext:^(id x) {
        if([x length] > 11){
            _tfAccount.text = [x substringToIndex:11];
        }
    }];
    
    [[_btnCode rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[self.vm.getCodeCommand execute:nil]subscribeNext:^(id x) {
            [MBProgressHUD hideWithSuccessAndMsg:@"验证码已发送" inView:self.view];
        } error:^(NSError *error) {
            [MBProgressHUD hideWithFailureAndMsg:error.localizedDescription inView:self.view];
        }];
    }];
    
    [[_btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[self.vm.validateCommand execute:nil] subscribeNext:^(id x) {
            
        } error:^(NSError *error) {
            
        }];
    }];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
