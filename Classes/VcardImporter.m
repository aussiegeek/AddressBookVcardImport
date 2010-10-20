//
//  VcardImporter.m
//  AddressBookVcardImport
//
//  Created by Alan Harper on 20/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VcardImporter.h"


@implementation VcardImporter
- (void)parse {
    addressBook = ABAddressBookCreate();
    
    [self emptyAddressBook];
    
    NSString *filename = [[NSBundle mainBundle] pathForResource:@"vCards" ofType:@"vcf"];
    NSLog(@"openning file %@", filename);
    NSData *stringData = [NSData dataWithContentsOfFile:filename];
    NSString *vcardString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    
    NSArray *lines = [vcardString componentsSeparatedByString:@"\n"];
    
    for(NSString* line in lines) {
        [self parseLine:line];
    }
    
    ABAddressBookSave(addressBook, NULL);

    [vcardString release];
}

- (void) parseLine:(NSString *)line {
    if ([line hasPrefix:@"BEGIN"]) {
        personRecord = ABPersonCreate();
    } else if ([line hasPrefix:@"END"]) {
        ABAddressBookAddRecord(addressBook,personRecord, NULL);
    } else if ([line hasPrefix:@"N:"]) {
        [self parseName:line];
    }
}

- (void) parseName:(NSString *)line {
    NSArray *upperComponents = [line componentsSeparatedByString:@":"];
    NSArray *components = [[upperComponents objectAtIndex:1] componentsSeparatedByString:@";"];
    ABRecordSetValue (personRecord, kABPersonLastNameProperty,[components objectAtIndex:0], NULL);
    ABRecordSetValue (personRecord, kABPersonFirstNameProperty,[components objectAtIndex:1], NULL);
    ABRecordSetValue (personRecord, kABPersonPrefixProperty,[components objectAtIndex:3], NULL);
}

- (void) emptyAddressBook {
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    int arrayCount = CFArrayGetCount(people);
    ABRecordRef abrecord;
    
    for (int i = 0; i < arrayCount; i++) {
        abrecord = CFArrayGetValueAtIndex(people, i);
        ABAddressBookRemoveRecord(addressBook,abrecord, NULL);
    }
    CFRelease(people);
}
@end
