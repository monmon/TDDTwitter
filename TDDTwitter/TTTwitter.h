//
//  TTTwitter.h
//  TDDTwitter
//
//  Created by  on 11/10/31.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>

@interface TTTwitter : NSObject
- (void)sendPublicTimelineToDelegate:(id)aDelegate withSelector:(SEL)aSelector;
@end
