//
//  WFPresentationTests.m
//  WFPresentationTests
//
//  Created by Evadne Wu on 4/23/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "WFPresentationTests.h"
#import "WFPresentation.h"

@implementation WFPresentationTests

- (void) testInstantiation {

	NSString * const name = @"TestTemplate";
	WFPresentationTemplate *template = [WFPresentationTemplate templateNamed:name];
	
	STAssertNotNil(template, @"Template named %@ must exist", name);

}

@end
