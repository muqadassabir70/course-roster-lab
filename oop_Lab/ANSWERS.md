# Campus Library System Lab — Reflection Answers

**Name:** Muqadas Sabir  
**Roll Number:** 04072313021


### Q1. What can a subclass using extends use for free that a class using implements has to write itself?

A subclass using `extends` inherits the parent's implemented methods, fields, and behaviour, so it only needs to add or override what is necessary. A class using `implements` inherits no implementation from the interface and must implement all its required members itself.

### Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?
I would use a mixin when unrelated classes need to share reusable behaviour, such as the renewal functionality of Book and Dvd. I would use an abstract parent class when the classes share a common identity, fields, or base behaviour, such as LibraryItem.

### Q3. Why must you override hashCode whenever you override ==?

When two objects are equal according to `==`, they must return the same `hashCode`. Sets and maps rely on this rule to identify equal objects correctly and avoid storing duplicate keys or values.

### Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?

Dart extension methods add convenience methods to an existing type without changing or inheriting from its implementation. Dart does not allow extending `String` because it is a final type, so extensions provide a way to add helper functionality without subclassing it.