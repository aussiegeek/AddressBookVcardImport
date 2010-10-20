//
//  AddressBookVcardImportAppDelegate.h
//  AddressBookVcardImport
//
//  Created by Alan Harper on 20/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressBookVcardImportViewController;

@interface AddressBookVcardImportAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AddressBookVcardImportViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AddressBookVcardImportViewController *viewController;

@end

