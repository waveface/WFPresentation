//
//  WFPresentationTemplate+Caching.m
//  WFPresentation
//
//  Created by Evadne Wu on 4/23/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "WFPresentationTemplate+Caching.h"
#import <objc/runtime.h>

static NSString *kTemplateCache = @"+[WFPresentationTemplate(Caching) templateCache]";

@implementation WFPresentationTemplate (Caching)

+ (NSCache *) templateCache {

	NSCache *cache = objc_getAssociatedObject([self class], &kTemplateCache);
	if (!cache) {
		
		cache = [[NSCache alloc] init];
		objc_setAssociatedObject([self class], &kTemplateCache, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	}
	
	return cache;

}

+ (id) cachedTemplateNamed:(NSString *)name {

	return [[self templateCache] objectForKey:name];

}

+ (void) cacheTemplate:(WFPresentationTemplate *)template withName:(NSString *)name {

	[[self templateCache] setObject:template forKey:name];

}

@end
