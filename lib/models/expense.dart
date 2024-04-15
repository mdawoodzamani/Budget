class Expense {
  int? id;
  String title;
  String price;
  int isIncome; // 1 - true   0 - false
  DateTime date;
  String imageUrl;

  Expense({
    required this.title,
    required this.price,
    required this.isIncome,
    required this.date,
    required this.imageUrl,
  });

  Expense.withId({
    this.id,
    required this.title,
    required this.price,
    required this.isIncome,
    required this.date,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['price'] = int.parse(price);
    map['isIncome'] = isIncome;
    map['date'] = date.toIso8601String();
    map['imageUrl'] = imageUrl;
    return map;
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense.withId(
      id: map['id'],
      title: map['title'],
      price: map['price'].toString(),
      isIncome: map['isIncome'],
      date: DateTime.parse(map['date']),
      imageUrl: map['imageUrl'],
    );
  }

  @override
  String toString() => 'title: $title, price: $price, date: ${date.toIso8601String().substring(0,10)}';
}
