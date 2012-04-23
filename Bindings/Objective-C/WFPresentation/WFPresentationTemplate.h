//
//  WFPresentationTemplate.h
//  WFPresentation
//
//  Created by Evadne Wu on 4/23/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFPresentationTemplate : NSObject

+ (id) templateNamed:(NSString *)name;

- (id) initWithContentsOfFileAtURL:(NSURL *)fileURL baseURL:(NSURL *)baseURL;

- (NSString *) documentWithReplacementVariables:(NSDictionary *)variablesToValues;

@property (nonatomic, readonly, strong) NSURL *fileURL;
@property (nonatomic, readonly, strong) NSURL *baseURL;

@end
