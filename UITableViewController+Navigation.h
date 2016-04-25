//
//  UITableViewController+Navigation.h
//  InfiniteScrollingList
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (Navigation)

#pragma mark - Methods
-(UINavigationController *) wrappedInNavigation;

@end
