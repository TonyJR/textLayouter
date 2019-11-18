//
//  BookShelfViewController.m
//  TheMostBeautiful
//
//  Created by Tony on 19/11/17.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "BookShelfViewController.h"
#import "TMBBookModel.h"
#import "BookShelfCollectionViewCell.h"

#define kBookShelfCellTag @"BookShelfCollectionViewCell"

@interface BookShelfViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray<TMBBookModel *> *dataLit;

@end

@implementation BookShelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registCells];
    [self initUI];
}

- (void)registCells{
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookShelfCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kBookShelfCellTag];
}

- (void)initUI{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat width = kScreenWidth / 3 - 30;
    layout.itemSize = CGSizeMake(width, width * 1.33);
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

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataLit count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TMBBookModel *model = [self.dataLit objectAtIndex:indexPath.row];
    BookShelfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBookShelfCellTag forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDataSource
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
