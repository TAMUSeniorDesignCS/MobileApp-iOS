//
//  XYZMessagesView.h
//  iOS App
//
//  Created by John Nowotny on 3/24/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZMessagesView : UITableViewController{
    NSMutableArray *userNames;
    NSMutableArray *dates;
    NSMutableDictionary *messages;
    NSMutableArray *messageIDs;
    NSMutableArray *firstNames;
}

@end
