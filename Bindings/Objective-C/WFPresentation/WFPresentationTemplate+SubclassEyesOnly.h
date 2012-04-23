//
//  WFPresentationTemplate+SubclassEyesOnly.h
//  WFPresentation
//
//  Created by Evadne Wu on 4/23/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "WFPresentation.h"

@interface WFPresentationTemplate (SubclassEyesOnly)

+ (id) newTemplateNamed:(NSString *)name usingBaseURL:(NSURL **)baseURL;

@end
