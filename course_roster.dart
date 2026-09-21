/// Course Roster Console App — Lab 1
void main(List<String> args) {
  // Part 1: Setup & Welcome
  printWelcome('Course Roster Manager');

  // Part 2: Course & Roster Data
  const int maxCapacity = 4; // true compile-time constant
  final DateTime createdAt = DateTime.now(); // known only at runtime, set once
  String courseTitle = 'CS201: Mobile App Development';
  // Part 8 (stretch): a CLI argument overrides the title
  if (args.isNotEmpty) {
    courseTitle = args[0];
  }
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};

  print(
    '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}',
  );
  print('Created at: $createdAt');

  // Check yourself: only createdAt can't be const, because DateTime.now() is
  // known only at runtime. The others are kept non-const on purpose:
  // courseTitle can be reassigned and the collections can change later.

  // Part 3: Null-Safe Instructor Info
  String? instructorEmail;
  print(instructorEmail ?? 'TBA');

  late String enrollmentCode; // assigned after declaration
  enrollmentCode = generateCode(courseTitle);
  print('Enrollment code: $enrollmentCode');

  // Deliberate crash (kept commented so the file runs):
  // print(instructorEmail!.length); // null check operator used on a null value
  // Safe version:
  print('Email length: ${instructorEmail?.length ?? 0}');

  // Part 4: Formatting Strings
  String rawNames = ' Aiden , maria ,JAMAL , Priya ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }
  print('Clean names: $cleanNames');

  String description = '''
Learn to build mobile apps with Flutter and Dart.
Weekly labs, one project, and a final demo.
Credit hours: $creditHours''';
  print(description);

  print('Seats left: ${capacity - enrolledStudents.length}');

  // Part 5: Operators in Action
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full groups of 3: $fullGroups, leftover: $leftover');

  Object formInput = 'twenty-two'; // simulates an untyped source
  if (formInput is String) {
    print('This is text!');
  }
  if (formInput is! int) {
    print('Not a number.');
  }

  final report = StringBuffer()
    ..write('Report: $courseTitle')
    ..write(' | Cap: $capacity')
    ..write(' | Roster: ${enrolledStudents.length}');
  print(report.toString());

  List<String>? extraNotes;
  extraNotes?..add('Room change pending'); // skipped: extraNotes is null
  print('Extra notes: $extraNotes');

  int? bonusSeats;
  bonusSeats ??= 0;
  print('Bonus seats: $bonusSeats');

  // Part 6: Enrollment Logic
  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Sorry, the course is full or closed.');
  }

  int enrollmentStatusCode = 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  // Part 7: Reports & Loops
  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((key, value) {
    print('$key: $value');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];
  for (var announcement in announcements) {
    print(announcement);
  }

  // Part 8 (stretch): Set.union preview
  Set<String> otherWaitlist = {'Priya', 'Zara'};
  Set<String> mergedWaitlist = waitlist.union(otherWaitlist);
  print('Merged waitlist: $mergedWaitlist');
}

/// Prints a banner around [appName], e.g. `=== My App ===`.
void printWelcome(String appName) {
  print('=== $appName ===');
}

/// Builds an enrollment code from the first two letters of [title].
String generateCode(String title) =>
    '${title.substring(0, 2).toUpperCase()}101';
