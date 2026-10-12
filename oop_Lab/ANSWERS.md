# OOP Lab Answers
Name: MUQADAS
Roll no: 04072313021

Q1. A subclass using `extends` gets real, working code and fields for free from the parent — it can reuse them directly. A class using `implements` only copies the API shape; it must write every method itself from scratch.

Q2. A mixin fits when unrelated classes (like Book and Dvd here) need to share the exact same ready-made behaviour, without an is-a relationship. An abstract parent class fits when the classes genuinely are the same kind of thing and share both structure and a contract they must each fulfill.

Q3. Dart's Set and Map use hashCode to quickly find which "bucket" an object belongs to, then use == to confirm a match. If two objects are == but have different hashCode values, they can land in different buckets and never get compared, so sets/maps would behave incorrectly (duplicates not detected, lookups failing).

Q4. An extension method adds new behaviour without creating a new type — the object is still exactly a String. A subclass of String is not allowed because String (like several core Dart types) is marked as a type that cannot be extended, to keep its behaviour predictable and efficient; extensions were designed as the safe way to add functionality instead.