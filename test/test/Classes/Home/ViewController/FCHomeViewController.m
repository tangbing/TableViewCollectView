//
//  FCHomeViewController.m
//  test
//
//  Created by fccoder on 2020/7/13.
//  Copyright © 2020 fccoder. All rights reserved.
//

#import "FCHomeViewController.h"
#import "FCTestViewController.h"

@interface FCHomeViewController ()
@end

@implementation FCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *l = [UILabel new];
    l.text = @"点击屏幕";
    [self.view addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FCTestViewController *vc = [FCTestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
