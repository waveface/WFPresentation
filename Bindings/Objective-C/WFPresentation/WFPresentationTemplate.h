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
- (NSString *) documentWithReplacementVariables:(NSDictionary *)replacementVariables;

@end
