// library_lab.dart - Campus Library System
// Name: MUQADAS SABIR  Roll no: 04072313021

const String rollNo = '04072313021';

final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;
final int feePerDay = 5 + t;
final int daysLate = 3 + (t + u) % 6;
final int daysBig = 10 + u;
final int feeCap = 150 + 10 * t;
final int renewLimit = 1 + t % 3;
final int renewAttempts = 2 + u;
final int shelfSize = 3 + u % 4;
// ==========================================================================

abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year) {
    created++;
  }

  static int created = 0;

  static int capFee(int fee) => fee > feeCap ? feeCap : fee;

  String describe() => '$title ($year)';

  int lateFee(int days);
}

mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) return false;
    renewals++;
    return true;
  }
}

abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

Book mainBook() => Book(titles[u], yearOf(u), 100 + 3 * seed);

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine() {
  var i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  var i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - (discountPercent * fee ~/ 100);
}

extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((word) => word[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) =>
      fold(0, (sum, item) => sum + item.lateFee(days));
}

class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine other) => Fine(amount + other.amount);

  bool operator >(Fine other) => amount > other.amount;

  @override
  bool operator ==(Object other) =>
      other is Fine && amount == other.amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

List<LibraryItem> buildShelf() {
  List<LibraryItem> result = [];

  for (var k = 0; k < shelfSize; k++) {
    var i = (u + k) % 10;

    if (k % 3 == 0) {
      result.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      result.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      result.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }

  return result;
}

class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    var fee = item.lateFee(days);
    fee = LibraryItem.capFee(fee);
    fee = type.applyDiscount(fee);
    return Fine(fee);
  }
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');

  var b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // Think: item.pages is a compile error because item is declared as
  // LibraryItem, and LibraryItem does not declare a pages field.
  // The actual object is a Book, but the declared type controls which
  // members are accessible at compile time.
}

void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // Think: if @override were omitted and describe were misspelled as
  // descibe, Dart could treat it as a separate method. Calling describe()
  // would then use the inherited implementation without the pages text.
}

void step3() {
  print('--- Step 3 ---');

  print(
    'Step 3: Book late fee for $daysLate days = '
    '${mainBook().lateFee(daysLate)}',
  );
  print(
    'Step 3: Magazine late fee for $daysLate days = '
    '${mainMagazine().lateFee(daysLate)}',
  );
  print(
    'Step 3: Dvd late fee for $daysLate days = '
    '${mainDvd().lateFee(daysLate)}',
  );
  // Think: LibraryItem cannot be instantiated directly because it is
  // abstract and lateFee has no implementation. Concrete subclasses
  // must provide the missing method.
}

void step4() {
  print('--- Step 4 ---');

  var book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (var item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }

  // Think: extending Borrowable would inherit any implemented members
  // if it had them. Here it declares only an abstract contract, so the
  // concrete class still needs to implement all three members.
}

void step5() {
  print('--- Step 5 ---');

  var book = mainBook();
  var ok = 0;

  for (var attempt = 0; attempt < renewAttempts; attempt++) {
    if (book.renew(renewLimit)) ok++;
  }

  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // Think: a mixin shares reusable renewal behavior with Book and Dvd
  // without forcing Magazine to have renewal functionality too.
}

void step6() {
  print('--- Step 6 ---');

  var type = MemberType.values[seed % 3];
  var fee = mainBook().lateFee(daysLate);

  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');

  // Think: an enum is safer than a String because its values are fixed
  // and compiler-checked. A misspelled enum value causes a compile error.
}

void step7() {
  print('--- Step 7 ---');

  var discounted = MemberType.values[seed % 3]
      .applyDiscount(mainBook().lateFee(daysLate));

  print('Step 7: ${discounted.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');

  var shelf = [mainBook(), mainMagazine(), mainDvd()];
  print(
    'Step 7: shelf fee for $daysLate days = '
    '${shelf.totalLateFee(daysLate).rs}',
  );

  // Think: 72.rs lets the extension read like a property of the int
  // and makes the formatting helper convenient to discover and use.
}

void step8() {
  print('--- Step 8 ---');

  var f1 = Fine(mainBook().lateFee(daysLate));
  var f2 = Fine(mainMagazine().lateFee(daysLate));

  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');

  // Think: equal objects must have equal hash codes. Without a matching
  // hashCode override, hash-based collections may handle equal objects
  // inconsistently, so == and hashCode must agree.
}

void step9() {
  print('--- Step 9 ---');

  LibraryItem.created = 0;
  buildShelf();
  var shelf = buildShelf();
  print('Step 9: items created = ${LibraryItem.created}');
  print(
    'Step 9: capped fee = '
    '${LibraryItem.capFee(shelf.first.lateFee(daysBig))} (cap $feeCap)',
  );
  print(
    'Step 9: const copies identical? '
    '${identical(const Fine(10), const Fine(10))}',
  );
  print(
    'Step 9: new copies identical? ${identical(Fine(10), Fine(10))}',
  );

  // Think: created is static, so it belongs to the class rather than
  // an individual object and can be accessed through LibraryItem.
}

void step10() {
  print('--- Step 10 ---');

  var shelf = buildShelf();
  var member = Member('S$seed', MemberType.values[seed % 3]);

  var total = shelf.fold<Fine>(
    const Fine(0),
    (sum, item) => sum + member.feeFor(item, daysLate),
  );

  var borrowable = shelf.where((item) => item is Borrowable).length;
  var renewable = shelf.where((item) => item is Renewable).length;

  print(
    'Step 10: ${shelf.length} items, $borrowable borrowable, '
    '$renewable renewable',
  );
  print('Step 10: ${member.name} (${member.type.name}) owes $total');
  print('Step 10: over the cap? ${total > Fine(feeCap)}');
}
