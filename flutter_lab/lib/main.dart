// main.dart - Study Tracker lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'MUQADAS';
const String rollNo = '04072313021';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
// Stateless: it only sets up the MaterialApp shell once; nothing here
// ever changes after the app starts.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Study Tracker', home: HomePage());
  }
}

// Stateless: it just lays out other widgets; the data that actually
// changes (the tally, the countdown) lives inside those child widgets.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Think (step 1): runApp only ever receives the single root widget
    // (LabApp). MaterialApp.home is the first screen to show inside
    // that app.
    // Think (step 3): LabApp -> MaterialApp -> HomePage -> Scaffold ->
    // SingleChildScrollView -> Column -> Row -> Text('Max: ..') is the
    // chain, so the Max text sits 8 widgets deep counting LabApp as
    // level 1.
    return Scaffold(
      appBar: AppBar(title: Text('Study Tracker: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(name: studentName, roll: rollNo, course: course),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),
            const Tally(),
            const SizedBox(height: 12),
            const Countdown(),
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

// Stateless: name, roll and course are fixed once given, so there's no
// internal data that ever changes.
// Think: fields must be final because a StatelessWidget's whole job is
// to describe a fixed picture from the values it was given. Marking a
// field non-final would still compile on its own, but using this widget
// as const StudentCard(...) requires every field to be final — a const
// object must never change after it is built.
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}

// Stateless: it only ever paints whatever count/max it's handed.
// Think: GoalBanner doesn't need setState because it never owns the
// count itself — it just paints whatever it was given. To show a new
// number, whoever creates it has to change its own state and rebuild,
// passing a fresh count into a new GoalBanner.
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({super.key, required this.count, required this.max});

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;
    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Stateful: _count changes every time a button is tapped, so it needs a
// State object to hold that memory across rebuilds.
// Think: Tally itself holds no changing field — it's just the config
// Flutter rebuilds freely. _TallyState is where _count actually lives,
// and that object survives across rebuilds of Tally, which is why there
// are two classes: one disposable config, one persistent memory.
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  int _count = startCount;

  // Think: hot reload (r) injects new code but keeps the existing State
  // object alive, so _count stays 12. Hot restart (R) tears the app
  // down and calls main() again, creating a brand-new State, so _count
  // resets to startCount.
  void _plus() {
    setState(() {
      _count += stepSize;
      if (_count > maxCount) _count = maxCount;
    });
  }

  void _minus() {
    setState(() {
      _count -= stepSize;
      if (_count < 0) _count = 0;
    });
  }

  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// Stateful: _left counts down every second and _builds tracks rebuilds,
// both have to survive across rebuilds driven by the Timer.
// Think (step 8): if _timer.cancel() is missing from dispose and the
// widget is removed, the Timer keeps firing and calling setState on a
// State object that's no longer mounted — Flutter throws "setState()
// called after dispose()".
// Think (step 9): builds go up by exactly one per second because each
// timer tick fires setState exactly once. To prove dispose ran, you
// could print lifecycleLog from a button that removes Countdown from
// the tree.
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;
  int _builds = 0;

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _left = startSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);
      if (_left <= 0) timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _left > 0
            ? Text('Time left: $_left s', key: const Key('time-left'))
            : const Text('Time is up!', key: Key('time-left')),
        Text('Builds: $_builds', key: const Key('builds')),
      ],
    );
  }
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
// Stateful: _clicks changes every tap, so it needs its own State.
// Think: before the fix, 3 taps made _clicks = 6 inside the State
// (3 * bugStep), but the screen kept showing 0, because build() was
// never told to run again — the data changed in memory, the picture on
// screen did not.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}
