//
//  RZWaiter.h
//  RZUtils
//
//  Created by Nick Bonatsakis on 06/19/2013.
//  Copyright (c) 2014 RaizLabs. All rights reserved.
//

#import "RZWaiter.h"

@implementation RZWaiter

+ (void)waitWithTimeout:(NSTimeInterval)timeout
           pollInterval:(NSTimeInterval)pollingInterval
         checkCondition:(RZWaiterPollBlock)conditionBlock
              onTimeout:(RZWaiterTimeout)timeoutBlock
{
    NSParameterAssert(conditionBlock);
    NSParameterAssert(timeoutBlock);
    
    int times = timeout / pollingInterval;
    for ( int i = 0; i < times; i++ ) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:pollingInterval]];
        if ( conditionBlock != nil && conditionBlock() ) {
            return;
        }
    }
    if ( timeoutBlock != nil ) {
        timeoutBlock();
    }
}

@end
