//
//  XYZSecondViewController.h
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZSecondViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    NSMutableArray *myPosts;
    NSMutableArray *firstNames;
    NSMutableArray *userNames;
    NSMutableArray *dates;
    NSMutableArray *postIDs;
}

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *newPostButton;


@end
