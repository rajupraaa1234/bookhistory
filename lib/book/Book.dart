class Book {
  String id;
  String name;
  String author;
  double price;

  Book({required this.id, required this.name, required this.author, required this.price});

  @override
  String toString() {
    return 'id = $id, name = $name, author = $author, price = $price';
  }

  Map<String, Object?> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'author': this.author,
      'price': this.price
    };
  }
}



