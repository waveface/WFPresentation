# WFPresentation

Evadne Wu at Waveface Inc., 2012.

This project deals with CSS formatting for content readable on all the devices.


## Using the raw HTML files

For your convenience, the CSS counterparts are also tracked, and you don’t really have to bundle them up.  Include these files:

*	WFPreviewIE.css
*	WFPreviewPrint.css
*	WFPreviewScreen.css
*	WFPreviewTemplate.html

And you can start using the project in your software.

There are also several substitution variables available:

*	$TITLE
*	$BODY
*	$ADDITIONAL_STYLES


## Using the `WFPresentation` binding class

In the project’s `Bindings > Objective-C` directory, there is WFPresentation which builds for iOS 5 + ARC.  The class is template agnostic.

Do this:

	NSString * const name = @"SomeTemplate";
	WFPresentationTemplate *template = [WFPresentationTemplate templateNamed:name];
	
Then, later on, do this:

	NSDictionary *replacement = [NSDictionary dictionaryWithObjectsAndKeys:@"Heading", @"$HEADING", nil];
	NSString *result = [template documentWithReplacementVariables:replacement];

The project assumes that, for a template named `Foo`, you put `Foo.html` in your app target’s Resources directory.  To change this behavior, override `+[WFPresentationTemplate templateBaseURL]`.

You’re currently responsible for making sure that replacement variable keys are unique in the body text and in all the replacement values.  File a feature request so we know you’re really using the project :)


## Licensing

The project uses the MIT license.  Commercial uses require attribution.


## Special thanks to

*	[Better Web Readability Project](http://code.google.com/p/better-web-readability-project/) from which a lot of code was stolen.

*	Original project name “synergised” courtesy of [Developer Lorem Ipsum](http://developerloremipsum.com/).
