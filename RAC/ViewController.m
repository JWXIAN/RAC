//
//  ViewController.m
//  RAC
//
//  Created by GJW on 16/7/27.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textPwd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@" 按钮被点击 ");
        return [RACSignal empty];
    }];
    
//    [[self.textField.rac_textSignal
//      filter:^BOOL(NSString *value){
//          NSString *text = value;
//          return text.length > 3;
//      }]
//     subscribeNext:^(id x){
//         NSLog(@"%@", x);
//     }];
    
//    //信号 长度
//   [[[self.textField.rac_textSignal map:^id(NSString *value) {
//       return @(value.length);
//    }]filter:^BOOL(NSNumber *value) {
//        return [value integerValue] > 3;
//    }]
//    subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    RACSignal *userNameSignal = [self.textField.rac_textSignal map:^id(NSString *value) {
        return @([self isValidUsername:value]);
    }];
    
    //接受信号，改变背景色
    RAC(self.textField, backgroundColor) =
    [userNameSignal
     map:^id(NSNumber *passwordValid){
         return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor redColor];
     }];
}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
