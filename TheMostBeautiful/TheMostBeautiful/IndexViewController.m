//
//  IndexViewController.m
//  TheMostBeautiful
//
//  Created by Tony on 19/11/17.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "IndexViewController.h"
#import "BookShelfViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

+ (instancetype)indexViewController{
    IndexViewController *result = [[self alloc] init];
    result.itemList = @[
                        ({
                            TOPageItem *item = [TOPageItem itemWithTitle:@"发现" highlightedTitle:nil icon:nil highlightedIcon:nil viewController:[UIViewController new]];
                            item;
                        }),
                        ({
                            TOPageItem *item = [TOPageItem itemWithTitle:@"做书" highlightedTitle:nil icon:nil highlightedIcon:nil viewController:[UIViewController new]];
                            item;
                        }),
                        ({
                            TOPageItem *item = [TOPageItem itemWithTitle:@"我的" highlightedTitle:nil icon:nil highlightedIcon:nil viewController:[BookShelfViewController new]];
                            item;
                        }),

                        ];
    [self.titleView reloadData];
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.titleView.mas_top);
    }];
    [self.titleView setSelectedIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
