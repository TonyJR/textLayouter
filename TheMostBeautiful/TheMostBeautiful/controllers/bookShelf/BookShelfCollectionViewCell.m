//
//  BookShelfCollectionViewCell.m
//  TheMostBeautiful
//
//  Created by Tony on 19/11/17.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "BookShelfCollectionViewCell.h"

@implementation BookShelfCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TMBBookModel *)model{
    _model = model;
    if (model) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    }else{
        self.imageView.image = [UIImage imageNamed:@"bookShelf_createBook"];
    }
}

@end
