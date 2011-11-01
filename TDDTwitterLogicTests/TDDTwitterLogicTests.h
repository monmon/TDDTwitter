//
//  TDDTwitterLogicTests.h
//  TDDTwitterLogicTests
//
//  Created by  on 11/10/31.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface TDDTwitterLogicTests : SenTestCase {
  BOOL _isDone;
  
  NSDictionary *_publicTimeline;
}

@property (strong, nonatomic) NSDictionary *publicTimeline;

- (void)stopLoopAndSetPublicTimeline:(NSDictionary *)aPublicTimeline;
@end
