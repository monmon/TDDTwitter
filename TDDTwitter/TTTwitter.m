//
//  TTTwitter.m
//  TDDTwitter
//
//  Created by  on 11/10/31.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TTTwitter.h"

@implementation TTTwitter


- (void)sendPublicTimelineToDelegate:(id)aDelegate withSelector:(SEL)aSelector {

  TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"] parameters:nil requestMethod:TWRequestMethodGET];
  
  // Perform the request created above and create a handler block to handle the response.
  [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {   
    NSError *jsonParsingError = nil;
    NSArray *key =  [NSArray arrayWithObjects:@"status", @"body", nil];
    NSArray *val = [NSArray arrayWithObjects:[NSNumber numberWithInteger:[urlResponse statusCode]], [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError], nil];
    NSDictionary *publicTimeline = [NSDictionary dictionaryWithObjects:val forKeys:key];
    
    if ([aDelegate respondsToSelector:aSelector]) {
      // aDelegateはidなので警告が出るのは仕方ないのかなぁ。何かやりようがあるかなぁ。
      [aDelegate performSelector:aSelector withObject:publicTimeline];
    } else {
      NSLog(@"...... No selector ......");
    }
  }];
}


@end
