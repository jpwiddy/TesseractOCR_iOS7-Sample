//
//  ResultsViewController.m
//  TesseractOCR
//
//  Created by Jake Widmer on 12/5/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *returnedTextLabel;
@property (strong, nonatomic) NSString * sentText;

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated{
    [self.returnedTextLabel setText:self.sentText];
}
- (void) setLabelTo:(NSString *)text{
    NSLog(@"Sent text : %@",text);
    self.sentText = text;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handlers

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
