//
//  FinishInterviewDialog.m
//  MHS Prototype
//
//  Created by arn on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FinishInterviewDialog.h"

@implementation FinishInterviewDialog

- (id)init
{
    self = [super initWithNibName:@"FinishInterviewDialog" bundle:nil];
    
    if (!self) return nil;
    return self;
}

-(IBAction)backAssignedInterviewClick:(id)sender
{

    [_logic switchToAssignedInterviews];
   
}


#pragma mark - TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 	
	static NSString *CellIdentifier = @"FinishInterviewCell";
	
    FinishInterviewCell *cell = (FinishInterviewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
		NSArray * objs = [[NSBundle mainBundle] loadNibNamed:@"FinishInterviewCell" owner:nil options:nil];
        for (id currentObj in objs){
            if([currentObj isKindOfClass:[UITableViewCell class]])
            {
                cell = (FinishInterviewCell *)currentObj;
                break;            
            }
        }
    }
    	
	return cell;	
}


#pragma mark - Table View delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 84; // --- set height for rows of custom table view
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1; //--- set default 1 number of section because only had one section's
}



#pragma mark - Public Methods

-(void)reloadTable
{
}

-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidLoad
{
    _img_photo_f.image = [UIImage imageNamed:@"default_photo.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [_img_photo_f release];
    _img_photo_f = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)dealloc {
    [_img_photo_f release];
    [super dealloc];
}
@end
