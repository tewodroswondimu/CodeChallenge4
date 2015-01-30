//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "Dog.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *personDogs;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
}

- (void)viewWillAppear:(BOOL)animated
{
    self.personDogs = [NSArray new];

    if (self.person.dogs.count) {
        // Create an arry of all dogs the person has
        self.personDogs = [self.person.dogs allObjects];
    }
    [self.dogsTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.person.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    Dog *dog = [self.personDogs objectAtIndex:indexPath.row];
    cell.textLabel.text = dog.name;
    cell.detailTextLabel.text = dog.breed;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Check whether the delete button was pressed
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dogsTableView beginUpdates];

        // find the dog that was deleted and remove it from the person's dog list
        Dog *deletedDog = self.personDogs[indexPath.row];
        [self.person removeDogsObject:deletedDog];

        [self.dogsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [self.context save:nil];

        [self.dogsTableView endUpdates];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddDogViewController *advc = [segue destinationViewController];
    advc.context = self.context;
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        advc.person = self.person;
    }
    else if ([segue.identifier isEqualToString:@"EditSegue"])
    {
        advc.dog = self.personDogs[self.dogsTableView.indexPathForSelectedRow.row];
    }
}

@end
