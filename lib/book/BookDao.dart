import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Book.dart';

class BookDao{

  static BookDao? _bookDao;
  static Database? _database;

  BookDao._createInstance();

  factory BookDao(){
    if (_bookDao == null) {
      _bookDao = BookDao._createInstance();
    }
    return _bookDao!;
  }

  Future<Database> get database async{
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var database = await openDatabase(join(await getDatabasesPath(), 'book.db'), version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    String sql = 'CREATE TABLE books(id TEXT PRIMARY KEY, name TEXT, author TEXT, price DOUBLE)';
    await db.execute(sql);
  }

  // CRUD Operations
  void insertBook(Book book) async{
    final db = await this.database;
    db.insert('books', book.toMap());
  }

  Future<List<Book>> getBooks() async {
    final db = await this.database;
    List<Map<String, dynamic>> mapRows = await db.query('books');
    return List.generate(mapRows.length, (index) {
      var book =  Book(
        id: mapRows[index]['id'].toString(),
        name: mapRows[index]['name'],
        author: mapRows[index]['author'],
        price: mapRows[index]['price']
      );
      return book;
    });
  }

  updateBook(Book book) async {
    final db = await this.database;
    db.update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
  }

  deleteBook(String id) async {
    Database db = await this.database;
    db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Book>> getBook(String bookName) async{
    Database db = await this.database;
    String sql = "SELECT * FROM books WHERE name LIKE \'$bookName\%\'";
    List<Map<String, dynamic>> mapRows = await db.rawQuery(sql);
    return List.generate(mapRows.length , (index) {
      var book =  Book(
          id: mapRows[index]['id'].toString(),
          name: mapRows[index]['name'],
          author: mapRows[index]['author'],
          price: mapRows[index]['price']
      );
      return book;
    });
  }

}