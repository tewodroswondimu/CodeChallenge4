//
//  Person+JSON.m
//  Assessment4
//
//  Created by Tewodros Wondimu on 1/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Person+JSON.h"

@implementation Person (JSON)

+ (void)getNewOwnersFromJSONWithContext:(NSManagedObjectContext *)context andCompletion:(void(^)(NSMutableArray *owners))completion
{
    NSMutableArray *ownersArray = [NSMutableArray new];

    // Dog owners data online
    NSString *url = @"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json";

    // create a url with the json file
    NSURL *jsonUrl = [NSURL URLWithString:url];

    // request to fetch the url
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:jsonUrl];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError)
        {
            // Creates a array of all the people you know
            NSArray *arrayOfAllOwnersFromJSON = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];

            // For every name in the list of people create a friend with the name equal to that string and the isFriend set to false
            for (NSString *personName in arrayOfAllOwnersFromJSON) {

                // Create a new NSManagedObject for each person in the JSON
                Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
                person.name = personName;
                [ownersArray addObject:person];

                [context save:nil];
            }
        }
        else if (connectionError)
        {
            // Display the connection error if it doesn't log in
            NSLog(@"%@", connectionError);
        }
        completion(ownersArray);
    }];
}

@end
