import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookhistory/book/Book.dart';
import 'package:bookhistory/book/BookDao.dart';

class InsertBookScreen extends StatefulWidget {
  const InsertBookScreen({Key? key}) : super(key: key);

  @override
  _InsertBookScreenState createState() => _InsertBookScreenState();
}

class _InsertBookScreenState extends State<InsertBookScreen> {

  TextEditingController idController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController authorController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  Book? book;

  String buttonName = "Add";
  String appBarText = "Add Book";

  @override
  Widget build(BuildContext context) {

    if (ModalRoute.of(context)!.settings.arguments != null) {
      book = ModalRoute.of(context)!.settings.arguments as Book;
      idController.text = book!.id;
      nameController.text = book!.name;
      authorController.text = book!.author;
      priceController.text = book!.price.toString();

      buttonName = "Update";
      appBarText = "Update Book";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                child: TextFormField(
                  controller: idController,
                  decoration: _decorate("Enter book id", "Book Id")
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: _decorate("Enter book name", "Book Name")
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                child: TextFormField(
                  controller: authorController,
                  decoration: _decorate("Enter Author Name", "Author Name")
                ),
              ),
              TextFormField(
                controller: priceController,
                decoration: _decorate("Enter book price", "Price")
              ),
              ElevatedButton(
                onPressed: () {
                  _insertOrUpdateBook();
                },
                child: Text(buttonName),
              )
            ],
          )
        ),
      ),
    );
  }

  InputDecoration _decorate(String hintText, String labelText) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.teal)
      ),
      contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    );
  }

  void _insertOrUpdateBook() async{
    try {
      String bookId = idController.text.toString();
      String bookName = nameController.text.toString();
      String authorName = authorController.text.toString();
      double bookPrice = double.parse(priceController.text);

      Book book = Book(id: bookId, name: bookName, author: authorName, price: bookPrice);
      final _bookDao = new BookDao();
      if(buttonName == "Add"){
        _bookDao.insertBook(book);
       // _bookDao.updateBook(book);
      } else {
        _bookDao.updateBook(book);
      }
      Navigator.pop(context);
    } catch(err) {
      print(err.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Wrong input'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Ok'),
            ),
          ],
        )
      );
    }
  }
}