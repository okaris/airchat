//
//  OKViewController.m
//  AirChat
//
//  Created by Ömer Karışman on 16.10.2013.
//  Copyright (c) 2013 Okaris. All rights reserved.
//

#import "OKViewController.h"

@interface OKViewController ()

@end

@implementation OKViewController
@synthesize interaction;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *bubbleImageRight = [[UIImage imageNamed:@"chatBubbleBlue"] stretchableImageWithLeftCapWidth:23 topCapHeight:17];

    
    // UIImage *bubbleImageRight = [[UIImage imageNamed:@"chatBubbleBlue"] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 23, 17, 23)];
    [imageView setImage:bubbleImageRight];
}

- (void) viewDidAppear:(BOOL)animated
{
    [inputTextField becomeFirstResponder];
}
-(NSArray*)subviewsOfView:(UIView*)view withType:(NSString*)type{
    NSString *prefix = [NSString stringWithFormat:@"<%@",type];
    NSMutableArray *subviewArray = [NSMutableArray array];
    for (UIView *subview in view.subviews) {
        NSArray *tempArray = [self subviewsOfView:subview withType:type];
        for (UIView *view in tempArray) {
            [subviewArray addObject:view];
        }
    }
    if ([[view description]hasPrefix:prefix]) {
        [subviewArray addObject:view];
    }
    return [NSArray arrayWithArray:subviewArray];
}

-(void)addColorToUIKeyboardButton{
    for (UIWindow *keyboardWindow in [[UIApplication sharedApplication] windows]) {
        for (UIView *keyboard in [keyboardWindow subviews]) {
            for (UIView *view in [self subviewsOfView:keyboard withType:@"UIKBKeyplaneView"]) {
                UIView *newView = [[UIView alloc] initWithFrame:[(UIView *)[[self subviewsOfView:keyboard withType:@"UIKBKeyView"] lastObject] frame]];
                newView.frame = CGRectMake(newView.frame.origin.x + 2, newView.frame.origin.y + 1, newView.frame.size.width - 4, newView.frame.size.height -3);
                [newView setBackgroundColor:[UIColor greenColor]];
                newView.layer.cornerRadius = 4;
                [view insertSubview:newView belowSubview:((UIView *)[[self subviewsOfView:keyboard withType:@"UIKBKeyView"] lastObject])];
                
            }
        }
    }
}
- (void) keyboardWillShow:(NSNotification *) notification
{
    [UIView beginAnimations:nil context:NULL];
    float duration = (float)[[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:[[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    composeBar.frame = CGRectMake(0, self.view.frame.size.height - 210 - 50, 320, 44);
    [UIView commitAnimations];
}

- (void) keyboardWillHide:(NSNotification *) notification
{
    [UIView beginAnimations:nil context:NULL];
    float duration = (float)[[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:[[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    composeBar.frame = CGRectMake(0, self.view.frame.size.height - 50, 320, 44);
    [UIView commitAnimations];
}

- (void) textFieldDidChange:(UITextField *)textField
{
    overlayLabel.text = textField.text;


}

- (CGFloat) heightForStringDrawing:(NSString *)myString font:(UIFont *)myFont width:(float) myWidth
{
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:myString];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(myWidth, FLT_MAX)] ;
    ;
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage addAttribute:NSFontAttributeName value:myFont
                        range:NSMakeRange(0, [textStorage length])];
    [textContainer setLineFragmentPadding:0.0];
    
    (void) [layoutManager glyphRangeForTextContainer:textContainer];
    return [layoutManager
            usedRectForTextContainer:textContainer].size.height;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (IBAction) selectPhoto:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    UIImageView *newImage = [[UIImageView alloc] initWithFrame:imageView.frame];
    [newImage setFrame:CGRectMake(newImage.frame.origin.x, newImage.frame.origin.y, newImage.frame.size.width, 200)];

    [airChatView addConstraint:[NSLayoutConstraint constraintWithItem:newImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:airChatView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-40.0]];
    
    newImage.contentMode = UIViewContentModeScaleAspectFill;
    newImage.clipsToBounds = YES;
    newImage.image = chosenImage;
    UIImageView *maskImageView = [[UIImageView alloc] initWithFrame:newImage.frame];
    [maskImageView setImage:[[UIImage imageNamed:@"chatBubbleBlue"] stretchableImageWithLeftCapWidth:23 topCapHeight:17]];

    UIImage *_maskingImage = [self imageWithView:maskImageView];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = newImage.bounds;
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [newImage.layer setMask:_maskingLayer];
    [overlayLabel setFont:[UIFont boldSystemFontOfSize:17]];

    overlayLabel.hasStroke = YES;
    @try {
        [[[airChatView subviews] objectAtIndex:[[airChatView subviews] indexOfObject:imageView] - 1 ] removeFromSuperview];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    [airChatView insertSubview:newImage belowSubview:imageView];
    [imageView setHidden:YES];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 2.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithData:UIImagePNGRepresentation(img)];
}

- (IBAction) sendMessage:(id)sender
{
    UIImage *imageToSend = [self imageWithView:airChatView];
    NSString *jpgPath=[NSTemporaryDirectory() stringByAppendingPathComponent:@"fileToSend.png"];
    [UIImageJPEGRepresentation(imageToSend,1.f) writeToFile:jpgPath atomically:YES];
    NSURL *igImageHookFile = [NSURL fileURLWithPath:[[NSString alloc] initWithFormat:@"file://%@",jpgPath]];
    NSURL *fileToTransferURL = [NSURL fileURLWithPath:jpgPath];
    
    
    interaction = [UIDocumentInteractionController interactionControllerWithURL:fileToTransferURL];
    interaction.delegate = self;
    interaction.UTI = @"com.okaris.AirChat";
    [interaction presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
     
    
    NSArray *activityItems = [NSArray arrayWithObjects:imageToSend, nil];
    
    /*
    OKPersonActivity *person = [[OKPersonActivity alloc] init];
    person.activityImage = [UIImage imageNamed:@"769-male.png"];
    person.activityTitle = @"Hasan";
    person.delegate = self;
    
    OKPersonActivity *person2 = [[OKPersonActivity alloc] init];
    person2.activityImage = [UIImage imageNamed:@"768-female.png"];
    person2.activityTitle = @"Ayse";
    person2.delegate = self;

    
    NSArray *applicationActivities = @[person,person2];
*/
    
    /*
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeMail,UIActivityTypeMessage,UIActivityTypePostToTwitter,UIActivityTypePostToFacebook];

    activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:activityViewController animated:YES completion:nil];
     */
    UIDocumentInteractionController* docController = [UIDocumentInteractionController interactionControllerWithURL:igImageHookFile] ;
    [docController presentOptionsMenuFromRect:self.view.frame inView:self.view animated:YES];

}
/*
 This app allows you to send text messages over airdrop to people not in your contact list or even you don't know. The app works over AirDrop and allows you to send to anyone who has it enabled.
 
 Warning: This app currently works only on iPhone5, iPhone5S, iPhone5C iPod Touch 5G
 */
- (void) didChooseActivity:(UIActivity *)activity
{
    NSLog(@"Chosen Activity:%@",activity.activityTitle);
}

- (IBAction) resetMessage:(id)sender
{
    @try {
        [[[airChatView subviews] objectAtIndex:[[airChatView subviews] indexOfObject:imageView] - 1 ] removeFromSuperview];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    overlayLabel.hasStroke = NO;
    [overlayLabel setFont:[UIFont systemFontOfSize:17]];
    [imageView setHidden:NO];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView setImage:[[UIImage imageNamed:@"chatBubbleBlue"] stretchableImageWithLeftCapWidth:23 topCapHeight:17]];
    [overlayLabel setText:nil];
    inputTextField.text = @"";
}

- (IBAction) saveMessage:(id)sender
{
    UIImageWriteToSavedPhotosAlbum([self imageWithView:airChatView], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error   contextInfo: (void *) contextInfo
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
