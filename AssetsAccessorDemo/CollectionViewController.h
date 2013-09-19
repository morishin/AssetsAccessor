//
//  CollectionViewController.h
//  AssetsAccessorDemo
//
//  Created by 森川慎太郎 on 2013/09/19.
//
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol MyImagePickerControllerDelegate <NSObject>
@optional
- (void)didFinishPickingAsset:(ALAsset *)asset;
@end

@interface CollectionViewController : UICollectionViewController

@property (nonatomic, retain) id<MyImagePickerControllerDelegate> delegate;
@property (nonatomic, retain) NSArray *assets;

@end
