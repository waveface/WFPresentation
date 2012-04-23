//
//  WFPresentationTests.m
//  WFPresentationTests
//
//  Created by Evadne Wu on 4/23/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "WFPresentationTests.h"
#import "WFPresentation.h"


@interface WFPresentationTemplate_WFPresentationTestsOverride : WFPresentationTemplate

+ (NSURL *) templateBaseURL;

@end


@implementation WFPresentationTemplate_WFPresentationTestsOverride

+ (NSURL *) templateBaseURL {

	static dispatch_once_t onceToken;
	static NSURL *url = nil;
	dispatch_once(&onceToken, ^{
		
		url = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
		
	});
	
	return url;

}

@end


#define WFPresentationTemplate WFPresentationTemplate_WFPresentationTestsOverride

@implementation WFPresentationTests

- (void) testInstantiation {

	NSString * const name = @"TestTemplate";
	WFPresentationTemplate *template = [WFPresentationTemplate templateNamed:name];
	
	STAssertNotNil(template, @"Template named %@ must instantiate", name);

}

- (void) testReplacement {

	NSString * const name = @"TestTemplate";
	WFPresentationTemplate *template = [WFPresentationTemplate templateNamed:name];
	
	NSURL *fileURL = template.fileURL;
	STAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]], @"Folly Template should not exist");
	
	NSString *templateContents = @"<html><h1>$HEADING</h1><b>$BODY</b></html>";
	NSError *writeError = nil;
	BOOL didWrite = [templateContents writeToURL:fileURL atomically:YES encoding:NSUTF8StringEncoding error:&writeError];
	STAssertTrue(didWrite, @"%@", writeError);
	
	NSDictionary *replacement = [NSDictionary dictionaryWithObjectsAndKeys:@"Heading", @"$HEADING", nil];
	NSString *result = [template documentWithReplacementVariables:replacement];
	NSString *desiredString = @"<html><h1>Heading</h1><b>$BODY</b></html>";
	STAssertEqualObjects(result, desiredString, @"Mismatch!");
	
	NSError *removeError = nil;
	BOOL didRemove = [[NSFileManager defaultManager] removeItemAtURL:fileURL error:&removeError];
	STAssertTrue(didRemove, @"%@", removeError);
	
}

@end
