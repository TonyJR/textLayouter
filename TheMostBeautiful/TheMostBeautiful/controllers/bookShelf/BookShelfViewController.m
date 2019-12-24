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
#import "TMBBookModel.h"
#import <MJRefresh/MJRefresh.h>

#define kBookShelfCellTag @"BookShelfCollectionViewCell"

@interface BookShelfViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray<TMBBookModel *> *_dataList;
}

@property (nonatomic,strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray<TMBBookModel *> *dataList;
@property (nonatomic,strong) MJRefreshStateHeader *header;

@end

@implementation BookShelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registCells];
    [self initUI];
    [self loadData];
}


- (void)registCells{
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookShelfCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kBookShelfCellTag];
}

- (void)initUI{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat width = kScreenWidth / 3 - 30;
    layout.itemSize = CGSizeMake(width, width * 1.33);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    
    [self.collectionView setMj_header:self.header];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)loadData{
    TOTask *task = [[TOTask alloc] initWithPath:kPathWebServer(@"/book/list") parames:nil taskOver:^(TOTask *task) {
        NSArray<TMBBookModel *> *dataList = [TMBBookModel mj_objectArrayWithKeyValuesArray:task.responseInfo[@"bookList"]];
        self.dataList = dataList;
        [self.header endRefreshing];
    }];
    task.lockScreen = NO;
    [task startAtOnce];
}

- (MJRefreshStateHeader *)header{
    if (!_header) {
        @weakify(self);
        _header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self loadData];
        }];
    }
    return _header;
}

#pragma mark - Getter 
- (NSArray<TMBBookModel *> *)dataList{
    if (!_dataList) {
        _dataList = @[];
    }
    return _dataList;
}

#pragma mark - Setter
- (void)setDataList:(NSArray<TMBBookModel *> *)dataList{
    _dataList = dataList;
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (TMBBookModel *)modelForIndexPath:(NSIndexPath *)indexPath{
    TMBBookModel *model = [self.dataList objectAtIndex:indexPath.row-1];
    return model;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataList count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        BookShelfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBookShelfCellTag forIndexPath:indexPath];
        cell.model = nil;
        return cell;
    }else{
        
        BookShelfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBookShelfCellTag forIndexPath:indexPath];
        cell.model = [self modelForIndexPath:indexPath];
        return cell;
    }
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //新建
    }else{
        //选择已有书籍
        TMBBookModel *model = [self modelForIndexPath:indexPath];
        
    }
    return NO;
}

#pragma mark - UICollectionViewDataSource


@end
