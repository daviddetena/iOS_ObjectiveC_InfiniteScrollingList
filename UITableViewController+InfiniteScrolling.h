//
//  UITableViewController+InfiniteScrolling.h
//  InfiniteScrollingList
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (InfiniteScrolling)


#pragma mark - Properties
@property(nonatomic) NSInteger numberOfSections;


#pragma mark - Methods
// Syntactic sugar method: to check if we are at the placeholder section
-(BOOL) isPlaceholderSection:(NSInteger) aSection;
// Set cell as one of placeholderCell type as default, or aCell
-(void) setPlaceholderCell:(UITableViewCell *) aCell;
// This method is used to perform the stuff necessary in a completion block in the background (e.g. download or fetch data), and return the placeholder cell with the new data
-(UITableViewCell *) placeholderCellWithBackgroundLoadingBlock: (void(^)(void)) loadingBlock;
// In case we are at the placeholder section, the height this cell may have
-(CGFloat) heightForPlaceholderCell;

@end