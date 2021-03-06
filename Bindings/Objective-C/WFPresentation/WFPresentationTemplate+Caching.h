//
//  WFPresentationTemplate+Caching.h
//  WFPresentation
//
//  Created by Evadne Wu on 4/23/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "WFPresentation.h"

@interface WFPresentationTemplate (Caching)

+ (id) cachedTemplateNamed:(NSString *)name;
+ (void) cacheTemplate:(WFPresentationTemplate *)template withName:(NSString *)name;

@end
