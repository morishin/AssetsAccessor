//
//  CollectionViewController.m
//  AssetsAccessorDemo
//
//  Created by 森川慎太郎 on 2013/09/19.
//
//

#import "CollectionViewController.h"

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Methods for CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeMake(70, 70);
    return cellSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.row];
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:[asset thumbnail]];
    UIImageView *thumbnailView = [[UIImageView alloc] initWithImage:thumbnail];
    [cell.contentView addSubview:thumbnailView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(didFinishPickingAsset:)]){
        [self.delegate didFinishPickingAsset:self.assets[indexPath.row]];
    }
}


@end
