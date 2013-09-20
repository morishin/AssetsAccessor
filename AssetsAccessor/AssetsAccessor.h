//
//  AssetsAccessor.h
//
//  Created by Shintaro Morikawa on 2013/09/14.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol AssetsAccessorDelegate <NSObject>
@optional
- (void)assetDidLoadByURL:(ALAsset *)asset;
- (void)assetDidFailLoadWithError:(NSError *)error;
- (void)assetsDidLoadByURLs:(NSArray *)assets;

- (void)assetsGroupsDidLoad:(NSArray *)groups;
- (void)assetsDidLoadByGroup:(NSArray *)assets;
@end

@interface AssetsAccessor : NSObject {
    BOOL isGettingMultipleAssets;
    int numURLs;
    NSMutableArray *assetsArray;
}

@property (nonatomic, weak) id<AssetsAccessorDelegate> delegate;
@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;

- (id)init;
- (id)initWithDelegate:(id<AssetsAccessorDelegate>)delegate;
- (void)getAssetByURL:(NSURL *)assetURL;
- (void)getAssetsByURLs:(NSArray *)assetURLs;
- (void)getAssetsGroupsWithTypes:(ALAssetsGroupType)groupTypes;
- (void)getAssetsFromGroup:(ALAssetsGroup *)group withFilter:(ALAssetsFilter *)filter;

@end
