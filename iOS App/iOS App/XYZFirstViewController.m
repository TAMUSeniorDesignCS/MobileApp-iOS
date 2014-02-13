//
//  XYZFirstViewController.m
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import "XYZFirstViewController.h"

@interface XYZFirstViewController ()

@end

@implementation XYZFirstViewController

-(NSString *) getValueBetweenElement:(NSString *) element inHTML:(NSString *) html {
    NSString *result = nil;
    
    // Determine element location
    NSRange elementRange = [html rangeOfString:[NSString stringWithFormat:@"<%@>", element] options:NSCaseInsensitiveSearch];
    if (elementRange.location != NSNotFound)
    {
        // Determine end tag location based on beggining tag location
        NSRange endElementRange;
        
        endElementRange.location = elementRange.length + elementRange.location;
        endElementRange.length   = [html length] - endElementRange.location;
        endElementRange = [html rangeOfString:[NSString stringWithFormat:@"</%@>", element] options:NSCaseInsensitiveSearch range:endElementRange];
        
        if (endElementRange.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            elementRange.location += elementRange.length;
            elementRange.length = endElementRange.location - elementRange.location;
            
            result = [html substringWithRange:elementRange];
        }
    }
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *fullURL = @"http://www.aa.org/lang/en/aareflections.cfm";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSError *error;
    NSString *page = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSString *quote = nil;
    // Determine the italic location
    NSRange elementRange = [page rangeOfString:[NSString stringWithFormat:@"<i>"] options:NSCaseInsensitiveSearch];
    if (elementRange.location != NSNotFound)
    {
        // Determine end tag location based on beggining tag location
        NSRange endElementRange;
        endElementRange.location = elementRange.length + elementRange.location;
        endElementRange.length   = [page length] - endElementRange.location;
        endElementRange = [page rangeOfString:[NSString stringWithFormat:@"</i>"] options:NSCaseInsensitiveSearch range:endElementRange];
        if (endElementRange.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            elementRange.location += elementRange.length;
            elementRange.length = endElementRange.location - elementRange.location;
            quote = [page substringWithRange:elementRange];
        }
    }

    
    [_viewWeb loadHTMLString:quote baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
