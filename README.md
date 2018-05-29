!OBSOLETE! AssetsAccessor
==============

A Class for accessing Assets (photos and videos) in iOS device using the Assets Library Framework.

[Here](http://tech.camph.net/?p=154) is the post about this (Japanese).

Methods
-------
AssetsAccessor Class has the following methods.
```objc
- (void)getAssetByURL:(NSURL *)assetURL;
- (void)getAssetsByURLs:(NSArray *)assetURLs;
- (void)getAssetsGroupsWithTypes:(ALAssetsGroupType)groupTypes;
- (void)getAssetsFromGroup:(ALAssetsGroup *)group withFilter:(ALAssetsFilter *)filter;
```
And the following delegate methods corresponding to above.
AssetsAccessorDelegate Methods
---------------
```objc
- (void)assetDidLoadByURL:(ALAsset *)asset;
- (void)assetDidFailLoadWithError:(NSError *)error;
- (void)assetsDidLoadByURLs:(NSArray *)assets;
- (void)assetsGroupsDidLoad:(NSArray *)groups;
- (void)assetsDidLoadByGroup:(NSArray *)assets;
```

Example
-------
ExampleViewController.h
```objc
#import <UIKit/UIKit.h>
#import "AssetsAccessor.h"

@interface ExampleViewController : UIViewController <AssetsAccessorDelegate> {
    AssetsAccessor *assetsAccessor;
}
```
ExampleViewController.m
```objc
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    assetsAccessor = [[AssetsAccessor alloc] initWithDelegate:self];
    
    [assetsAccessor getAssetsGroupWithTypes:ALAssetsGroupAll];
}

#pragma mark - AssetsAccessorDelegate Methods

- (void)assetsGroupsDidLoad:(NSArray *)groups{
    NSLog(@"assetsGroupsDidLoad:%@",groups);
    
    ALAssetsGroup *aGroup = groups[0];
    [assetsAccessor getAssetsFromGroup:aGroup withFilter:[ALAssetsFilter allPhotos]];
}

- (void)assetsDidLoadByGroup:(NSArray *)assets{
    NSLog(@"assetsDidLoadByGroup:%@",assets);
    
    ALAsset *anAsset = assets[0];
    NSURL *imageURL = [[anAsset defaultRepresentation] url];
    [assetsAccessor getAssetByURL:imageURL];
}

- (void)assetDidLoadByURL:(ALAsset *)asset{
    NSLog(@"assetDidLoadByURL:%@",asset);
}

@end
```
