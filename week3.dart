// Week3.dart - Library Desk Assistant
// Name: Muqadas Sabir   Roll no: 04072313021

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

// Part 1: Functions and parameters
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

String formatTitle(String title, [String? author]) {
  if (author == null) return title;
  return '$title by $author';
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool isClassic(int year) => year < 2000;

// Part 2: Higher-order functions, closures, and recursion
List<String> transformAll(List<String> items, String Function(String) fn) {
  final result = <String>[];
  for (final item in items) {
    result.add(fn(item));
  }
  return result;
}

int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) return n;
  return n % 10 + sumDigits(n ~/ 10);
}

// Part 3: Collections
Map<String, int> buildStock() {
  return {
    for (final book in books)
      (book['title'] as String): (book['copies'] as int),
  };
}

// Part 4: Generics
class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) return fallback;
  return items.first;
}

class Pair<A, B> {
  final A first;
  final B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

// Part 5: Error handling
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((book) => book['title'] == title);
}

// Part 6: Future and async/await
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(const Duration(milliseconds: 500));
  throw Exception('Server down');
}

// Bonus B1: Group every title under each of its tags.
Map<String, List<String>> groupTitlesByTag() {
  final grouped = <String, List<String>>{};
  for (final book in books) {
    final title = book['title'] as String;
    for (final tag in book['tags'] as List<String>) {
      grouped.putIfAbsent(tag, () => <String>[]).add(title);
    }
  }
  return grouped;
}

// Bonus B2: A reusable, type-safe filter function.
List<T> filterBy<T>(List<T> items, bool Function(T) test) {
  return items.where(test).toList();
}

Future<void> main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
  await bonus();
}

void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');

  final titles = ['Dart in Action', 'Clean Code'];
  print(
    transformAll(titles, (String s) {
      return s.toUpperCase();
    }),
  );
  print(transformAll(titles, (s) => '$s!'));

  final desk1 = makeCounter();
  final desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  final studentFee = makeFeeCalculator(0.25);
  final staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');
  print('Sum of digits: ${sumDigits(2024)}');
}

void part3() {
  print('--- Part 3 ---');

  final titles = books.map((book) => book['title'] as String).toList();
  print('Titles: $titles');

  final available = books
      .where((book) => (book['copies'] as int) > 0)
      .map((book) => book['title'] as String)
      .toList();
  print('Available: $available');

  final totalCopies = books.fold<int>(
    0,
    (sum, book) => sum + (book['copies'] as int),
  );
  print('Total copies: $totalCopies');

  final years = books.map((book) => book['year'] as int).toList();
  final oldest = years.reduce(
    (first, second) => first < second ? first : second,
  );
  print('Oldest year: $oldest');

  final sortedBooks = List.of(books);
  sortedBooks.sort((x, y) => (x['year'] as int).compareTo(y['year'] as int));
  final sortedTitles = sortedBooks
      .map((book) => book['title'] as String)
      .toList();
  print('By year: $sortedTitles');

  final stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) print('Out of stock: $title');
  });
  print("Copies of Unknown: ${stock['Unknown'] ?? 0}");

  final Set<String> allTags = {
    for (final book in books) ...(book['tags'] as List<String>),
  };
  print('All tags: $allTags');

  final a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  final b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');

  final intBox = Box<int>(5);
  final stringBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');
  // intBox.value = 'hello'; // String cannot be assigned to an int box.

  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');

  final stock = buildStock();
  final requests = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];
  for (final title in requests) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } finally {
      print('Transaction logged.');
    }
  }
  print("Copies left of Dart in Action: ${stock['Dart in Action']}");

  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');
  print('Fetching...');
  final book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  // Without await, printing fetchBookOfTheDay() shows a Future, not its title.
  // Keep await in the final version so the expected output matches.

  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

Future<void> bonus() async {
  print('--- Bonus ---');

  // B1: Tag to titles mapping.
  print('Titles by tag: ${groupTitlesByTag()}');

  // B2: Repeat the available-books query using the generic filter.
  final availableBooks = filterBy(books, (book) => (book['copies'] as int) > 0);
  final availableTitles = availableBooks
      .map((book) => book['title'] as String)
      .toList();
  print('Available with filterBy: $availableTitles');

  // B3: Start both Futures before waiting for them together.
  final timer = Stopwatch()..start();
  final firstFetch = fetchBookOfTheDay();
  final secondFetch = fetchBookOfTheDay();
  final results = await Future.wait([firstFetch, secondFetch]);
  timer.stop();
  print('Parallel fetch results: $results');
  print('Parallel fetch time: ${timer.elapsedMilliseconds} ms');
}

// Reflection
// 1. I choose fold when I need a starting value or when the list may be empty.
//    Reduce needs at least one item and uses it as the starting value.
// 2. A closure captures a variable when it remembers that variable after the
//    outer function returns. makeCounter captures its own count variable.
// 3. A general catch (e) would catch BookNotAvailableException too, so its
//    specific on clause must come first to print the correct message.
// 4. Without await, the call returns a valid Future<String>, so it compiles.
//    Printing that Future does not print the String it will eventually produce.
