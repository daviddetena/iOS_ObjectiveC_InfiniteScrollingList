//
//  UITableViewController+InfiniteScrolling.m
//  InfiniteScrollingList
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import "UITableViewController+InfiniteScrolling.h"
#import <objc/runtime.h>

#define STANDARD_CELL_HEIGHT 44

// Keys for associated objects
static char numberOfSectionsKey;
static char placeholderCellKey;


@implementation UITableViewController (InfiniteScrolling)


#pragma mark - Properties
// We "can not" create properties in a category, so we need to use C's runtime methods getAssociatedObject / setAssociatedObject instead
-(NSInteger) numberOfSections{
    
    NSNumber *sections = objc_getAssociatedObject(self, &numberOfSectionsKey);
    NSAssert(sections, @"This shouldn't be nil. Set this before getting");
    
    // Return number of sectios + 1 (the placeholder cell)
    return [sections integerValue] + 1;
}

// We "can not" create properties in a category, so we need to use C's runtime methods getAssociatedObject / setAssociatedObject instead
-(void) setNumberOfSections:(NSInteger)numberOfSections{
    NSNumber *sections = @(numberOfSections);
    objc_setAssociatedObject(self, &numberOfSectionsKey, sections, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



#pragma mark - Main
// It's the placeholder section if it's the last one in the table
-(BOOL) isPlaceholderSection:(NSInteger)aSection{
    return (aSection == [self numberOfSections] - 1);
}


// Gets the new placeholder cell, execute in the background the loadingBlock you passed in through to get new model data, and refresh table
-(UITableViewCell *) placeholderCellWithBackgroundLoadingBlock:(void (^)(void))loadingBlock{
    
    // Create a background queue to run the block
    dispatch_queue_t background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(background, ^{
        
        // Run loading block
        loadingBlock();
        
        // Once done, send reloadData in the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
    // Now return the placeholder cell
    UITableViewCell *cell = [self placeholderCell];
    if(!cell){
        // Return the default one
        return [self defaultPlaceholderCell];
    }
    else{
        return cell;
    }
    
}


#pragma mark - Placeholder cell

// Create a default placeholder cell
-(UITableViewCell *) defaultPlaceholderCell{
    
    static NSString *cellId = @"loadingCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    // Create Activity Indicator and add to the placeholder cell
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    [spinner setFrame:CGRectMake(15, 12, 20, 20)];
    [cell addSubview:spinner];
    
    // Configure cell
    cell.textLabel.text = @"Loading...";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    
    return cell;
}

// We "can not" create properties in a category, so we need to use C's runtime methods getAssociatedObject / setAssociatedObject instead
-(UITableViewCell *) placeholderCell{
    return objc_getAssociatedObject(self, &placeholderCellKey);
}


// We "can not" create properties in a category, so we need to use C's runtime methods getAssociatedObject / setAssociatedObject instead
-(void) setPlaceholderCell:(UITableViewCell *)aCell{
    objc_setAssociatedObject(self, &placeholderCellKey, aCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// Return height of placeholder cell if exists or default height otherwise
-(CGFloat) heightForPlaceholderCell{
    
    UITableViewCell *cell = [self placeholderCell];
    if(cell){
        return cell.frame.size.height;
    }
    else{
        return STANDARD_CELL_HEIGHT;
    }
}

@end
