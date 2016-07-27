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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@" 按钮被点击 ");
        return [RACSignal empty];
    }];
    
    [[self.textField.rac_textSignal
      filter:^BOOL(id value){
          NSString*text = value;
          return text.length > 3;
      }]
     subscribeNext:^(id x){
         NSLog(@"%@", x);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
