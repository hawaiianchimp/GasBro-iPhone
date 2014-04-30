//
//  GBInfoViewController.h
//  GasBro
//
//  Created by Sean Thomas Burke on 1/16/14.
//  Copyright (c) 2014 Nyquist Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBInfoViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIImageView *profile;
    IBOutlet UIScrollView *scroll;
}

- (IBAction) unwindAction:(UIStoryboardSegue *)segue;

@end
