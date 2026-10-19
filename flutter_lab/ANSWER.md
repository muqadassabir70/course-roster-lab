# CS442 Flutter Lab - Study Tracker

Name: MUQADAS  
Roll No: 04072313021

## A Answers

A1: 7  
A2: 9  
A3: 6  
A4: 16

## B Answers

### B1

StudentCard, GoalBanner, LabApp, and HomePage are StatelessWidgets because their displayed structure depends on the data given to them and they do not store changing state. Tally, Countdown, and BuggyCounter are StatefulWidgets because their values change while the app is running.

### B2

The Timer must be cancelled in dispose() because the State object is no longer active after it is removed. Cancelling the Timer prevents it from continuing to fire and trying to update a disposed State.

### B3

Widgets such as LabApp, HomePage, StudentCard, GoalBanner, Tally, Countdown, and BuggyCounter can use const constructors when their configuration is constant. const allows Flutter/Dart to reuse constant widget objects and avoids unnecessary recreation of widgets whose configuration does not change.