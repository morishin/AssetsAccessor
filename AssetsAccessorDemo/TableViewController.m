//
//  TableViewController.m
//  AssetsAccessorDemo
//
//  Created by 森川慎太郎 on 2013/09/19.
//
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.groups.count==1 && [self.groups[0] numberOfAssets]==0) {
        [[[UIAlertView alloc] initWithTitle:@"No Photo" message:@"Please add some photos to this device." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }
    
    assetsAccessor = [[AssetsAccessor alloc] initWithDelegate:self];
}

#pragma mark - UIAlertViewDelegate Method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Methods for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToCollectionView"]) {
        CollectionViewController *collectionViewController = [segue destinationViewController];
        collectionViewController.delegate = self.parent;
        collectionViewController.assets = (NSArray *)sender;
    }
}

#pragma mark - TableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageWithCGImage:[self.groups[indexPath.row] posterImage]];
    cell.textLabel.text = [self.groups[indexPath.row] valueForProperty:ALAssetsGroupPropertyName];
    
    return cell;
}

#pragma mark - TableViewdelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [assetsAccessor getAssetsFromGroup:self.groups[indexPath.row] withFilter:[ALAssetsFilter allPhotos]];
}

#pragma mark - AssetsAccessorDelegate Methods

- (void)assetsDidLoadByGroup:(NSArray *)assets{
    [self performSegueWithIdentifier:@"ToCollectionView" sender:assets];
}

@end
