iOS-Quizkit
===========

iOS-Quizkit is an Objective-C API for creating applications with quiz and test features. 
For flexibility, the API focuses completely on the model layer and makes no attempt to offer a UI solution.

Included is a quick sample app with the library integrated. It provides an example of how the API might be integrated into an application.

**Note**: The sample app is not complete and does not work as expected :) 

Features:
- Multiple choice questions
- Open response questions with optional Levenshtein distance approximation
- True/False questions
- Full NSCodor support for quizzes, questions, and sessions.
- Load quizzes from user created Plists and JSON.
- Optional User Data on most structures.
- Automatic or custom scoring
- Retroactive session grading

```Objective-C
// Load Quiz from user plist
[ISQuizParser quizFromContentsOfPlist:...];

// Load Quiz from JSON file
[ISQuizParser quizFromContentsOfJSON:...];

// Load Quiz from bundle
[ISQuizParser quizNamed:...];

```

```Objective-C

// Start a new quiz session
ISSession* session = [ISSession session];
[session start:quiz];

// Submit answers
[session setResponse:[ISOpenQuestionResponse responseWithResponse:...] atIndex:0];
[session setResponse:[ISTrueFalseQuestionResponse responseWithResponse:...] atIndex:1];

[session stop];

// Grading
ISGradingResult* result = [quiz gradeSession:session];
NSLog(@"Score: %i/%i", result.points, result.pointsPossible);

```
