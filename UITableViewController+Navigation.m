//
//  UITableViewController+Navigation.m
//  InfiniteScrollingList
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import "UITableViewController+Navigation.h"

@implementation UITableViewController (Navigation)

#pragma mark - Methods
-(UINavigationController *) wrappedInNavigation{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    return nav;
}

@end
