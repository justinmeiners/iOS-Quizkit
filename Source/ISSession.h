/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import <Foundation/Foundation.h>
#import "ISQuiz.h"

@interface ISSession : NSObject <NSCoding>
{
    NSDate* _startDate;
    NSDictionary* _userData;
    NSMutableArray* _responses;
}
@property(nonatomic, copy)NSDate* startDate;
@property(nonatomic, readonly)NSArray* responses;
@property(nonatomic, retain)NSDictionary* userData;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)initWithQuiz:(ISQuiz*)quiz;

- (void)setResponse:(ISQuestionResponse*)response
            atIndex:(int)index;

// inserts an empty response
- (void)clearResponseAtIndex:(int)index;

- (BOOL)complete;

@end
