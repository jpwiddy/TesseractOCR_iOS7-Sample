//
//  ViewController.m
//  TesseractOCR
//
//  Created by Jake Widmer on 12/4/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//

#import "ViewController.h"
#import "ResultsViewController.h"
#import <TesseractOCR/TesseractOCR.h>

@interface ViewController ()
@property (strong,nonatomic) UIImage * imageReturned;
@property (strong,nonatomic) NSString * returnedText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) ResultsViewController * resultsVC;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.returnedText = @"";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cameraButtonPressed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if([UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No camera availiable." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - Delegate functions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Preparing");
    if ([[segue identifier] isEqualToString:@"toResultsSegue"]) {
        NSLog(@"Performing segue");
        [segue.destinationViewController setLabelTo:self.returnedText];
    }
}

#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // ... task 1 on main thread
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    // store image
    self.imageReturned = chosenImage;
    self.imageView.image = chosenImage;
    NSLog(@"Pic returned");
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)recognizeTextButtonPressed:(id)sender {
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    //language are used for recognition. Ex: eng. Tesseract will search for a eng.traineddata file in the dataPath directory.
    //eng.traineddata is in your "tessdata" folder.
    
//    [tesseract setVariableValue:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" forKey:@"tessedit_char_whitelist"];
    [tesseract setImage:self.imageReturned]; //image to check
    [tesseract recognize];
    
    NSLog(@"Text : %@", [tesseract recognizedText]);
    self.returnedText = [tesseract recognizedText];
    [tesseract clear];
    [self performSegueWithIdentifier:@"toResultsSegue" sender:self];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
