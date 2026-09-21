# Course Roster Console App (Lab 1)

**Name:** Muqadas Sabir
**Course:** CS 442, Mobile Application Development with Flutter & Dart

## Parts completed
- Part 1: Setup & Welcome
- Part 2: Course & Roster Data
- Part 3: Null-Safe Instructor Info
- Part 4: Formatting Strings
- Part 5: Operators in Action
- Part 6: Enrollment Logic
- Part 7: Reports & Loops
- Part 8 (stretch): CLI arguments, dart format, dart analyze, Set.union() preview

## How to run
```
dart run course_roster.dart
dart run course_roster.dart "CS210: Databases"
```

## dart analyze output
No errors. 4 `dead_code` warnings, which are intentional demos of
null-aware operators (`?.`, `?..`) on values that are always null, and
of constant conditions.