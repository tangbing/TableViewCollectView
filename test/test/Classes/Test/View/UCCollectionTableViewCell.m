//
//  UCCollectionTableViewCell.m
//  UnionCar
//
//  Created by Luigi on 2020/6/16.
//  Copyright © 2020 XiaMen Micro into digital information technology co., LTD. All rights reserved.
//

#import "UCCollectionTableViewCell.h"
#import "UCItemPickCollectionViewCell.h"

@interface UCCollectionTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation UCCollectionTableViewCell

- (void)setInfo:(NSDictionary *)info {
    _info = info;
    
    self.titleLabel.text = info[@"title"];
 //如果代码在主线程执行，能获取到真实高度，但不主动刷新布局（需要把cell滑出屏幕再滑回来才能显示正确的布局）
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
        
}

//尺寸拟合最符合目标大小，其中可以布置接收器的子树，同时以最佳方式满足约束。如果希望尽可能小的大小，请通过 UILayoutFitting 压缩大小;如果想要尽可能小的大小，请通过 UILayoutFittingCompressedSize;对于最大可能的大小， 通过 UILayoutfidedsize.
//另请参阅 UILayoutPriorityFittingSizeLevel 的注释。
/// 根据视图的约束与优先级，返回视图最佳大小
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{

    // 在对collectionView进行布局
    self.collectionView.frame = CGRectMake(0, 0, targetSize.width, 44);
    [self.collectionView layoutIfNeeded];
    
    // 由于这里collection的高度是动态的，这里cell的高度我们根据collection来计算
    CGSize collectionSize = self.collectionView.collectionViewLayout.collectionViewContentSize;
    CGFloat cotentViewH = collectionSize.height;
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, cotentViewH);
    
}


- (void)setupUI {

    //标题
    self.titleLabel = [UILabel new];
    self.titleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.collectionView];

    
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.right.bottom.mas_equalTo(self.contentView);
    }];
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(105, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *list = self.info[@"list"];
    return list.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *info = self.info[@"list"][indexPath.row];
    
    UCItemPickCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UCItemPickCollectionViewCell class]) forIndexPath:indexPath];
    cell.label.text = info[@"title"];
    return cell;
}

#pragma mark - GET
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[UCItemPickCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UCItemPickCollectionViewCell class])];
    }
    return _collectionView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    UCCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupUI];
    }
    return cell;
}
@end
