//
//  ViewController.m
//  TextPosition
//
//  Created by Tony on 19/11/21.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTextStorage *_storage;
    NSLayoutManager *_manager;
    NSTextContainer *_container;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"12345🇺🇸67890"];
    _storage = [[NSTextStorage alloc] initWithAttributedString:str];
    _manager = nslayout
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
