//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "Dog.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";

    if (self.dog) {
        [self updateViewWithDog];
    }
}

- (void)updateViewWithDog
{
    self.nameTextField.text = self.dog.name;
    self.breedTextField.text = self.dog.breed;
    self.colorTextField.text = self.dog.color;
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    // If the user is in Edit Mode save new data into the existing dog object
    if (self.dog) {
        self.dog.name = self.nameTextField.text;
        self.dog.breed = self.breedTextField.text;
        self.dog.color = self.colorTextField.text;

        // Animate back into the dogs view controller
        [self.navigationController popViewControllerAnimated:YES];
    }
    // Else create a new dog and insert new objects into that Entity
    else {
        Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.context];
        dog.name = self.nameTextField.text;
        dog.breed = self.breedTextField.text;
        dog.color = self.colorTextField.text;

        // Add the dog into the person's list of dogs
        [self.person addDogsObject:dog];

        // Dismiss the modal
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    // save your
    [self.context save:nil];
}

@end
