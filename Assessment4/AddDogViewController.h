//
//  AddDogViewController.h
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface AddDogViewController : UIViewController

@property NSManagedObjectContext *context;
@property Person *person;
@property Dog *dog;

@end
