//
//  Products.h
//  Giverny Prototype
//
//  Created by Edward Harpham on 24/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Products : NSManagedObject

@property (nonatomic, retain) NSNumber * productID;
@property (nonatomic, retain) NSString * name;

@end
