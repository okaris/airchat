//
//  OKViewController.h
//  AirChat
//
//  Created by Ömer Karışman on 16.10.2013.
//  Copyright (c) 2013 Okaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OKStrokedUILabel.h"
#import "OKPersonActivity.h"

@interface OKViewController : UIViewController <UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDocumentInteractionControllerDelegate, OKPersonactivityDelegate>
{
    
    IBOutlet UIToolbar *composeBar;
    IBOutlet UITextField *inputTextField;
    IBOutlet UIView *airChatView;
    IBOutlet UIImageView *imageView;
    IBOutlet OKStrokedUILabel *overlayLabel;
}

@property (nonatomic,strong) UIDocumentInteractionController *interaction;

- (IBAction) selectPhoto:(id)sender;
- (IBAction) sendMessage:(id)sender;
- (IBAction) resetMessage:(id)sender;
- (IBAction) saveMessage:(id)sender;

@end
