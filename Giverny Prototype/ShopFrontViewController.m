//
//  ShopFrontViewController.m
//  Giverny Prototype
//
//  Created by Edward Harpham on 24/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import "ShopFrontViewController.h"
#import "AppDelegate.h"


@interface ShopFrontViewController ()

@end

@implementation ShopFrontViewController
@synthesize productsCollectionView, tfUserText, currentPopoverSegue, pvc,bannerImages, bannerImageView, managedObjectContext;

static int photoCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    [self configureBanners];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (ProductCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flower%i",indexPath.row]];
    return cell;
    
}



#pragma mark – UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(285, 285);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout min:(NSInteger)section {
    
    return 0.0f;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self performSegueWithIdentifier: @"segPop" sender: self];
    
    }

/*                  *
 *  BANNER  METHODS *
 *                  */

-(void)configureBanners {
    
    self.bannerImages = [NSArray arrayWithObjects:@"banner1.jpg",@"banner2.jpg", @"banner3.jpg", nil];
    self.bannerImageView.image = [UIImage imageNamed:[self.bannerImages objectAtIndex:0]];
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(transitionPhotos) userInfo:nil repeats:YES];
    
    
}


-(void)transitionPhotos{
    
    
    if (photoCount < [self.bannerImages count] - 1){
        photoCount ++;
    }else{
        photoCount = 0;
    }
    [UIView transitionWithView:self.bannerImageView
                      duration:5.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ self.bannerImageView.image = [UIImage imageNamed:[self.bannerImages objectAtIndex:photoCount]]; }
                    completion:NULL];
}

/*                  *
 *  POPOVER METHODS *
 *                  */

- (void)dismissPop: (NSString *)value {
    [tfUserText setText:value]; // populates data from popover
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
}

-(void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender {
    if ([[segue identifier] isEqualToString:@"segPop"]) {
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
        [pvc setStrPassedValue:[tfUserText text]];}
    
}

@end
