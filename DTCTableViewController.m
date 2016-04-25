//
//  DTCTableViewController.m
//  InfiniteScrollingList
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import "DTCTableViewController.h"
#import "UITableViewController+InfiniteScrolling.h"

@interface DTCTableViewController ()

@property (nonatomic) NSInteger numberOfItems;

@end

@implementation DTCTableViewController


#pragma mark - View lifecycle


- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if(self){
        // Custom initilization
        self.title = @"Infinite scrolling";
        _numberOfItems = 20;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Actually, the number of sections will be 1 more (for the placeholder cell)
    self.numberOfSections = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}


// Rows per section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self isPlaceholderSection:section]){
        return 1;
    }
    else{
        return self.numberOfItems;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    
    // The current cell is the placeholder one
    if([self isPlaceholderSection:indexPath.section]){
        return [self placeholderCellWithBackgroundLoadingBlock:^{
            
            // Suspend the thread execution for 2 seconds to simulate we're busy downloading something. Then add 20 new items.
            sleep(2);
            self.numberOfItems = self.numberOfItems + 20;
        }];
    }
    else{
        // The current cell is not the placeholder one => standard cell creation
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            // Create new one
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        // Set text for the cell
        cell.textLabel.text = [NSString stringWithFormat:@"Entry #%ld", (long)indexPath.row + 1];
        return cell;
    }
}

@end
