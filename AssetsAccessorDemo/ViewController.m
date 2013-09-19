//
//  ViewController.m
//  AssetsAccessorDemo
//
//  Created by Shintaro Morikawa on 2013/09/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    assetsAccessor = [[AssetsAccessor alloc] initWithDelegate:self];
}

#pragma mark - IBActions

- (IBAction)pressSelectImage:(id)sender {
    [assetsAccessor getAssetsGroupWithTypes:ALAssetsGroupAll];
}

- (IBAction)pressGetImage:(id)sender {
    [assetsAccessor getAssetByURL:imageURL];
}

#pragma mark - Methods for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToTableView"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        TableViewController *tableViewController = navigationController.viewControllers[0];
        tableViewController.parent = self;
        tableViewController.groups = (NSArray *)sender;
    }
}

#pragma mark - MyImagePickerControllerDelegate Methods

- (void)didFinishPickingAsset:(ALAsset *)asset{
    [self dismissViewControllerAnimated:YES completion:nil];
    imageURL = [[asset defaultRepresentation] url];
    self.urlLabel.text = imageURL.absoluteString;
    self.urlLabel.textColor = [UIColor redColor];
    self.getButton.enabled = YES;
}

#pragma mark - AssetsAccessorDelegate Methods

- (void)assetsGroupsDidLoad:(NSArray *)groups{
    [self performSegueWithIdentifier:@"ToTableView" sender:groups];
}

- (void)assetDidLoadByURL:(ALAsset *)asset{
    UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
    self.imageView.image = image;
}

@end
