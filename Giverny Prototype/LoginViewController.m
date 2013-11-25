//
//  LoginViewController.m
//  Giverny Prototype
//
//  Created by Edward Harpham on 24/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"


@interface LoginViewController () {
    
    NSManagedObjectContext *context;
}

@end

@implementation LoginViewController

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
    
    [[self productTextField]setDelegate:self];
    [[self idTextField]setDelegate:self];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(id)sender {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Products" inManagedObjectContext:context];
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]init];
    [fetchReq setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", self.productTextField.text];
    [fetchReq setPredicate:predicate];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:fetchReq error:&error];
    
    //if nothing found
    if (result.count <=0) {
        self.displayLabel.text = @"NO RESULTS FOUND";
        
    //if something found
    } else {
        
        NSLog(@"%@",result);
        self.displayLabel.text = @"PERSON FOUND";

    }
    
}

- (IBAction)addButton:(id)sender {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Products" inManagedObjectContext:context];
    NSManagedObject *newProduct = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:context];
    
    [newProduct setValue:self.productTextField.text forKey:@"name"];
    NSError *error;
    [context save:&error];
    self.displayLabel.text = @"Person added";
}

- (IBAction)deleteButton:(id)sender {
    
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Products" inManagedObjectContext:context];
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]init];
    [fetchReq setEntity:entityDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", self.productTextField.text];
    [fetchReq setPredicate:predicate];
    NSError *error;
    NSArray *result = [context executeFetchRequest:fetchReq error:&error];
    
    //if nothing found
    if (result.count <=0) {
        self.displayLabel.text = @"NO RESULTS FOUND";
        
        //if something found - DELETE
    } else {
        
        for (NSManagedObject *obj in result) {
            [context deleteObject:obj];
        }
        [context save:&error];
    }


}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
