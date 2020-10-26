//
//  ViewController.m
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import "ViewController.h"

static NSString *cellIdentifier = @"FeedCustomCell";

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set the title of the screen
    self.navigationItem.title = @"";
    
    //Add button to navigation
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(fetchFeed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //Set the view to full bounds
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Set Collection views delegate and data source and add to view
     UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //Registering cells to collection view
    
    [_collectionView registerClass:[UICollectionViewCell class]
        forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[FeedCustomCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_collectionView setBackgroundColor:[UIColor systemBackgroundColor]];
    [self.view addSubview:_collectionView];
    
    //Add Activity indicator to view until the feed is downloaded
    [self showActivityIndicator];
    
    //Set the constraints of the view
    NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|" options:0 metrics:nil views:views]];
    
    //Set edges for the sections in collection view
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(8, 0, 8, 0);
    
    // Fetch the feed data from given URL.
    self.feedObj = [[FeedModel alloc] init];
    [self fetchFeed:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // invalidating layout on rotation and reloading the collection view to reset the data in the cells
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Private/Public Methods
-(void)showActivityIndicator
{
    //Create activity indicator view and add as subview to the view
     _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    _spinner.backgroundColor = [UIColor lightGrayColor];
    _spinner.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    _spinner.hidesWhenStopped = true;
    [self.view addSubview:_spinner];
}

- (void)fetchFeed:(id)sender
{
    // Removeing old data from Feed object
    [self.feedObj removeAll];
    [self.collectionView reloadData];
    
    //switch to background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //back to the main thread for the UI call
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view bringSubviewToFront:self.spinner];
            [self.spinner startAnimating];
        });
        //Creating feed download URL
        NSURL* feedUrl = [NSURL URLWithString:@"https://www.personalcapital.com/blog/feed/json"];
        
        //Creating URL Session for downloading feed
        [[[NSURLSession sharedSession] dataTaskWithURL:feedUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            //Converting data into json Dictionary
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            //Parsing json Dictionary into feed object
            [self.feedObj FillModelWithJSONDictionary:json];
            if (self.feedObj.items.count > 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //back to the main thread for the UI call
                    //Set the title of the screen
                    self.navigationItem.title = self.feedObj.title;
                    [self.spinner stopAnimating];
                    [self.collectionView reloadData];
                });
            }
        }] resume];
    });
}

#pragma mark - DataSource Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //Load collection data only when there is data aiviable
    if (self.feedObj.items.count > 0)
    {
        return self.feedObj.items.count;
    }
    return 0;
}

#pragma mark - Delegate Methods

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Check for feed data show collection view only when data is downloaded
    if (self.feedObj.items.count > 0)
    {
        FeedCustomCollectionViewCell *cell = (FeedCustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[FeedCustomCollectionViewCell alloc] initWithFrame:CGRectZero];
        }
        NSString *imageURL = [[NSString alloc] initWithString:[self.feedObj.items[indexPath.row] featured_image]];
        //Using custom lazy loading for images
        [cell.feedImage setImageFromUrl:imageURL atViewIndex:indexPath];
        
        if(indexPath.row == 0)
        {
            //First cell with title on one line with the rest ellipsed if necessary, and the first two lines of the summary with the rest ellipsed if necessary.
            cell.feedTitleLabel.text = [self.feedObj.items[indexPath.row] title];
            cell.feedTitleLabel.numberOfLines = 1;
            cell.feedDescriptionLabel.text = [self.feedObj.items[indexPath.row] summary];
        }
        else
        {
            //Secound title underneath (rendering at most 2 lines of the title with the rest ellipsed if necessary).
            cell.feedTitleLabel.text = [self.feedObj.items[indexPath.row] title];
            cell.feedTitleLabel.numberOfLines = 2;
            cell.feedDescriptionLabel.text = @"";
        }
        return cell;
    }
    else
    {
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat numberOfItemsPerRow = 3;
    if (indexPath.row == 0)
    {
        numberOfItemsPerRow = 1;
    }
    else
    {
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            numberOfItemsPerRow = 2;
        }
        else
        {
            numberOfItemsPerRow = 3;
        }
    }
    CGFloat width = collectionView.bounds.size.width;
    CGFloat spacing = 8;
    CGFloat availableWidth = width - spacing * (numberOfItemsPerRow + 1);
    CGFloat itemDimension = floor(availableWidth/numberOfItemsPerRow);
    return CGSizeMake(itemDimension, width/2);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
     return YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         [self.collectionView.collectionViewLayout invalidateLayout];
     }
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
     }];
}
//as soon as
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailsView = [[DetailsViewController alloc] init];
    detailsView.itemDetails = self.feedObj.items[indexPath.row];
    [self.navigationController pushViewController:detailsView animated:true];
}
@end
