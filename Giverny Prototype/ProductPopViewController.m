//
//  ProductPopViewController.m
//  Giverny
//
//  Created by Edward Harpham on 23/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import "ProductPopViewController.h"

@interface ProductPopViewController ()

@end

@implementation ProductPopViewController

@synthesize delegate, tfNewData,strPassedValue;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack: (id)sender {
    
    [delegate dismissPop:[tfNewData text]];  // make delegate callback here
    
}

- (void)viewWillAppear: (BOOL)animated {
    [tfNewData setText:strPassedValue];
}
@end
