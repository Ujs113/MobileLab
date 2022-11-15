import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Exercise5 extends StatefulWidget {
  const Exercise5({Key? key}) : super(key: key);

  @override
  State<Exercise5> createState() => _Exercise5State();
}

class _Exercise5State extends State<Exercise5> {

  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();

  final List<Map<String, dynamic>> listOfColumns = await users();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: firstnamecontroller,
                    decoration: const InputDecoration(
                      label: Text("Enter First Name"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextField(
                    controller: lastnamecontroller,
                    decoration: const InputDecoration(
                      label: Text("Enter Last Name"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    ),
                  )
                ],
              )
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if(firstnamecontroller.text != null && lastnamecontroller.text != null) {
                    listOfColumns.add({
                      "Firstname": firstnamecontroller.text,
                      "Lastname": lastnamecontroller.text
                    });
                  } else {


                  }
                });
              },
              child: const Text("Submit")
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: DataTable(
                columns: const [
                  DataColumn(label: Text("First Name")),
                  DataColumn(label: Text("Last Name"))
                ],
                rows:
                listOfColumns
                    .map(
                  ((element)=>DataRow(cells: <DataCell>[
                    DataCell(Text(element["Firstname"].toString())),
                    DataCell(Text(element["Lastname"].toString()))
                  ],
                  )),
                ).toList()
            ),
          )
        ],
      ),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Firstname': firstName,
      'Lastname': lastName,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, Firstname: $firstName, Lastname: $lastName}';
  }
}

class DbHelper {

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version){
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT)',
        );
      },
      version: 1,
    );
    return db;
  }
}

void insertUser(User user) async {
  Database db = await DbHelper.instance.database;
  int id = await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, dynamic>>> users() async{
  Database db = await DbHelper.instance.database;
  final List<Map<String, dynamic>> maps = await db.query('users');
  return maps;
}