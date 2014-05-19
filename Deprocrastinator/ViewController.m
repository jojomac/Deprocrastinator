//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Joanne McNamee on 5/19/14.
//  Copyright (c) 2014 JMWHS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property NSMutableArray *toDoArray;
@property (weak, nonatomic) IBOutlet UITableView *toDoTableView;
@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	self.toDoArray = [NSMutableArray arrayWithObjects:@"Ignore Don",
                      @"Buy Kevin Lunch",
                      @"Maker the early train",
                      @"Don't sleep in tomorrow", nil];
}
- (IBAction)onEditButtonPressed:(id)sender
{
    UIButton *editButton = sender;
    if([editButton.currentTitle isEqualToString:@"Edit" ])
    {
    [editButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else if([editButton.currentTitle isEqualToString:@"Done" ])
    {
        [editButton setTitle:@"Edit" forState:UIControlStateNormal];

    }


}

#pragma mark - Table Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell"];
    cell.textLabel.text = [self.toDoArray objectAtIndex:indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if([self.editButton.currentTitle isEqualToString:@"Edit"])
    {
    selectedCell.textLabel.textColor = [UIColor greenColor];
    }
    else
        [self.toDoArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
}


#pragma mark - Helper Methods

- (IBAction)onAddButtonPressed:(id)sender
{
    NSString *nextToDoItem = self.inputTextField.text;
    [self.toDoArray addObject:nextToDoItem];
    [self.inputTextField resignFirstResponder];
    self.inputTextField.text = @"";

    [self.toDoTableView reloadData];
    
}

- (IBAction)onSwipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer
{

    if ([self.editButton.currentTitle isEqualToString:@"Done"]) {

        if (swipeGestureRecognizer.state == UIGestureRecognizerStateEnded) {
            CGPoint swipeLocation = [swipeGestureRecognizer locationInView:self.toDoTableView];
            NSIndexPath *swipeIndex = [self.toDoTableView indexPathForRowAtPoint:swipeLocation];
            [self.toDoArray removeObjectAtIndex:swipeIndex.row];

            [self.toDoTableView reloadData];
        }
            }
    NSLog(@"Swiped");
}
@end
