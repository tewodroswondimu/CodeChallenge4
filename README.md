# CodeChallenge4

Dog Book

The purpose of this app is to allow the user to manage the data of individual dog owners and the dogs that they own.
Before You Begin

Open the project file supplied on the LMS. In this project, we have already created all the view controllers you will need, including the
tableview to display the list of dog owners (or, each Person) and the detail view controller listing all of the dogs they own.

The following JSON data provides the list of dog owners:

http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json

Note:​We have already connected your delegates and created IBOutlets for your UITableViews. We have also added all segues.

Using the above relationship within your core data model, your app should accomplish the following:
1. Display a list of dog owners’ names in the first ViewController. New dog owners can be added via the JSON data supplied. Save them
as managed objects in core data.

2. Implement MVC Design by consolidating the retrieval of the JSON Data in a separate model class.

3. Display a list of each dog owner’s dogs in the DogsViewController. The list should display the dog’s name, color and breed.

● New dogs must first be added using the AddDogViewController

● Save new dogs as managed objects in core data

● Note: a modal segue to the AddDogViewController has already been added and hooked up via the UIBarButtonItem in the
DogsViewController

4. When the user selects a color in the UIAlertView presented by the left UIBarButtonItem in the first ViewController, save this setting
so that every time the app is opened the user’s selected tint color is set by default

● Note: There are many ways to tackle this. If you want to do so by storing the UIColor as NSData, you must use NSKeyedArchiver
to convert to NSData, and NSKeyedUnarchiver to convert NSData back to UIColor object. UIColors also have RGB values that
are floats that can be stored as NSNumber types.

5. Allow the user to edit information about a dog from the AddDogViewController (after having segued from its UITableViewCell in the
DogsViewController).
6. Allow the user to delete a dog from the DogsViewController and from Core Data.
