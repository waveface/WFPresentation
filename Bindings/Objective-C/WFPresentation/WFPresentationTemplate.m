//
//  WFPresentationTemplate.m
//  WFPresentation
//
//  Created by Evadne Wu on 4/23/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "WFPresentationTemplate.h"
#import "WFPresentationTemplate+SubclassEyesOnly.h"
#import "WFPresentationTemplate+Caching.h"

#import "GTMNSString+HTML.h"

@interface WFPresentationTemplate ()

+ (dispatch_queue_t) dispatchQueue;

@property (nonatomic, readwrite, strong) NSURL *fileURL;
@property (nonatomic, readwrite, strong) NSURL *baseURL;
@property (nonatomic, readwrite, strong) NSString *contents;

@end


@implementation WFPresentationTemplate
@synthesize fileURL, baseURL, contents;

+ (dispatch_queue_t) dispatchQueue {

	static dispatch_once_t onceToken = 0;
	static dispatch_queue_t queue = NULL;
	dispatch_once(&onceToken, ^{
		
		queue = dispatch_queue_create(__PRETTY_FUNCTION__, NULL);
		
	});
	
	return queue;

}

+ (NSURL *) templateBaseURL {

	static dispatch_once_t onceToken;
	static NSURL *url = nil;
	dispatch_once(&onceToken, ^{
	
		url = [[NSBundle mainBundle] resourceURL];
		
	});
	
	return url;

}

+ (id) templateNamed:(NSString *)name {

	WFPresentationTemplate * const cachedTemplate = [self cachedTemplateNamed:name];
	
	if (cachedTemplate)
		return cachedTemplate;
	
	NSString *fileName = [name stringByAppendingPathExtension:@"html"];
	
	NSURL *baseURL = [[self class] templateBaseURL];
	NSURL *fileURL = [baseURL URLByAppendingPathComponent:fileName];
	
	NSError *error = nil;
	WFPresentationTemplate * const template = [[self alloc] initWithContentsOfFileAtURL:fileURL baseURL:baseURL];
	
	NSAssert1(template, @"%@", error);
	
	[self cacheTemplate:template withName:name];
	
	return template;

}

- (id) initWithContentsOfFileAtURL:(NSURL *)inFileURL baseURL:(NSURL *)inBaseURL {

	self = [super init];
	if (!self)
		return nil;
	
	fileURL = inFileURL;
	baseURL = inBaseURL;
	
	return self;

}

- (NSString *) contents {

	if (contents)
		return contents;
	
	__weak WFPresentationTemplate *wSelf = self;
	__block NSError *error = nil;

	dispatch_sync([[self class] dispatchQueue], ^{

		contents = [NSString stringWithContentsOfURL:wSelf.fileURL usedEncoding:NULL error:&error];
		
	});
	
	if (!contents)
		NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
	
	return contents;

}

- (NSString *) documentWithReplacementVariables:(NSDictionary *)vars {

	__block NSString *replacementString = [self.contents copy];
	
	NSStringCompareOptions const options = NSCaseInsensitiveSearch|NSLiteralSearch|NSDiacriticInsensitiveSearch|NSWidthInsensitiveSearch;
	
	[vars enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
	
		NSRange const range = (NSRange){ 0, [replacementString length] };

		replacementString = [replacementString stringByReplacingOccurrencesOfString:key withString:[value gtm_stringByEscapingForHTML] options:options range:range];
	
	}];
	
	return replacementString;

}

@end
