//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogsViewController.h"
#import "Person.h"
#import "Person+JSON.h"
#import "AppDelegate.h"

#define kColorValue @"colorValue"
#define kRedValue @"redValue"
#define kGreenValue @"greenValue"
#define kBlueValue @"blueValue"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property NSManagedObjectContext *context;

@property NSMutableArray *peopleArray;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Dog Owners";
    self.peopleArray = [NSMutableArray new];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;

    self.peopleArray = [[self loadEntityArrayWithEntityName:@"Person"] mutableCopy];

    if (!self.peopleArray.count) {
        [Person getNewOwnersFromJSONWithContext:self.context andCompletion:^(NSMutableArray *owners) {
            self.peopleArray = owners;
            [self.myTableView reloadData];
        }];
    }
    else
    {
        [self.myTableView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    // Updates user color preferences
    [self updateUserPreferences];
}

// Update the color preferences of the user
- (void)updateUserPreferences
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *color = [defaults valueForKey:kColorValue];
    if (color) {
        float redColor = [color[kRedValue] floatValue];
        float greenColor = [color[kGreenValue] floatValue];
        float blueColor = [color[kBlueValue] floatValue];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0];
    }
}

// Load all elements of an entity
- (NSArray *)loadEntityArrayWithEntityName:(NSString *)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];

    NSArray *array = [self.context executeFetchRequest:request error:nil];

    [self.myTableView reloadData];

    return array;
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peopleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    cell.textLabel.text = [[self.peopleArray objectAtIndex:indexPath.row] name];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];

        // Create a color dictionary to save into NSUserDefaults
        NSDictionary *color = [self colorDictionaryForRed:128.0 green:0 blue:128.0];
        [defaults setObject:color forKey:kColorValue];

        // Write updates to NSUserDefaults
        [defaults synchronize];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];

        // Create a color dictionary to save into NSUserDefaults
        NSDictionary *color = [self colorDictionaryForRed:0 green:0 blue:255.0];
        [defaults setObject:color forKey:kColorValue];

        // Write updates to NSUserDefaults
        [defaults synchronize];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];

        // Create a color dictionary to save into NSUserDefaults
        NSDictionary *color = [self colorDictionaryForRed:255.0 green:165.0 blue:0];
        [defaults setObject:color forKey:kColorValue];

        // Write updates to NSUserDefaults
        [defaults synchronize];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];

        // Create a color dictionary to save into NSUserDefaults
        NSDictionary *color = [self colorDictionaryForRed:0 green:255 blue:0];
        [defaults setObject:color forKey:kColorValue];

        // Write updates to NSUserDefaults
        [defaults synchronize];
    }
}

// Creates a dictionary with NSNumber values for the RGB values to be saved in the NSUserDefaults
- (NSDictionary *)colorDictionaryForRed:(float)red green:(float)green blue:(float)blue
{
    red = red/255.0;
    NSNumber *redColor = [NSNumber numberWithFloat:red];
    green = green/255.0;
    NSNumber *greenColor = [NSNumber numberWithFloat:green];
    blue = blue/255.0;
    NSNumber *blueColor = [NSNumber numberWithFloat:blue];
    NSDictionary *color = @{ kRedValue: redColor,
                             kGreenValue: greenColor,
                             kBlueValue: blueColor
                             };
    return color;
}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DogsViewController *dvc = [segue destinationViewController];
    dvc.context = self.context;
    dvc.person = [self.peopleArray objectAtIndex:self.myTableView.indexPathForSelectedRow.row];
}

@end
