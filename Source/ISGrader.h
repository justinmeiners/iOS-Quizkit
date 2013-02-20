/*
 Copyright (c) 2012 Inline Studios
 Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */


#import <Foundation/Foundation.h>
#import "ISQuiz.h"
#import "ISSession.h"


@interface ISGrader : NSObject

- (void)gradeSession:(ISSession*)session quiz:(ISQuiz*)quiz;

@end
