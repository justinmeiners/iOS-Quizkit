iOS-Quizkit
===========

Takes care of the model layer for apps with quizzes and tests. Contrary to the title this API will work on Mac as well as iOS.

This project is not yet complete. It is 99% there.

An example project is coming soon.

Features:
- Multiple choice questions
- Open response questions with optional Levenshtein distance range
- True/False questions
- Full NSCodor support for quizzes, questions, and sessions.
- Load quizzes from user created Plists.
- Optional User Data on most structures.


```Objective-C
// Load Quiz from user PLIST
[ISQuizParser quizFromContentsOfPlist:...];

// Load Quiz from JSON
[ISQuizParser quizFromContentsOfJSON:…];

// Load Quiz from bundle
[ISQuizParser quizNamed:…];

```