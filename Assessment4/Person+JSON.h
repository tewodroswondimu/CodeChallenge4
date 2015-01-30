//
//  Person+JSON.h
//  Assessment4
//
//  Created by Tewodros Wondimu on 1/30/15.
//  Catagory for the Person Entity
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Person.h"

@interface Person (JSON)

+ (void)getNewOwnersFromJSONWithContext:(NSManagedObjectContext *)context andCompletion:(void(^)(NSMutableArray *owners))completion;

@end
