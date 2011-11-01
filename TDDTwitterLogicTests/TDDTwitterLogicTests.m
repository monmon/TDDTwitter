//
//  TDDTwitterLogicTests.m
//  TDDTwitterLogicTests
//
//  Created by  on 11/10/31.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TDDTwitterLogicTests.h"
#import "TTTwitter.h"

@implementation TDDTwitterLogicTests

@synthesize publicTimeline = _publicTimeline;

- (void)setUp
{
  [super setUp];
    
  _isDone = NO;
}

- (void)tearDown
{
    // Tear-down code here.
    
  [super tearDown];
}

- (void)testGetPublicTimeline
{
  TTTwitter *twitter = [[TTTwitter alloc] init];
  [twitter sendPublicTimelineToDelegate:self withSelector:@selector(stopLoopAndSetPublicTimeline:)];

  // main thread は sub treadが_isDoneをYESにするまでloop
  while (!_isDone) {
    NSLog(@"Polling...");
  }
  
  STAssertNotNil(self.publicTimeline, @"public timelineはnilではない");
  
  NSNumber *statusCode = [self.publicTimeline objectForKey:@"status"];
  STAssertNotNil(statusCode, @"statusというkeyをもっている");
  
  id body = [self.publicTimeline objectForKey:@"body"];
  STAssertNotNil(body, @"bodyというkeyをもっている");
  
  if ([statusCode intValue] == 200) {
    STAssertTrue([body isKindOfClass:[NSArray class]], @"200のときはbodyの値はNSArrayのインスタンス");
  } else if ([statusCode intValue] == 400) {
    STAssertTrue([body isKindOfClass:[NSDictionary class]], @"400のときはbodyの値はNSDictonaryのインスタンス");
  } else {
    NSLog(@"statusCode: %@", statusCode);
  }
}
  
- (void)stopLoopAndSetPublicTimeline:(NSDictionary *)aPublicTimeline {         // sub threadで実行される
  _isDone = YES;
  
  // main threadでないとtestに失敗してもプログラムが正常終了してしまうので
  // ここではpropertyのsetだけして抜ける
  self.publicTimeline = aPublicTimeline;
}

@end
