import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String dbName = 'zone';
  static const String recipientsTable = 'recipients';
  static const String listTable = 'lists';
  static const String pointTable = 'points';

  Database? _db;
  String? _path;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    //create data base
    var documentDirectory = await getDatabasesPath();
    _path = join(documentDirectory, dbName);
    var db = await openDatabase(_path!, version: 1, onCreate: onCreate);
    // log('init');
    return db;
  }

  onCreate(Database db, int version) async {
    //create list table
    await db.execute('''CREATE TABLE $pointTable 
  (
  id INTEGER PRIMARY KEY,
  name TEXT,
  isListDownloaded INTEGER
  )''');

    await db.execute('''CREATE TABLE $listTable 
  (
  id INTEGER PRIMARY KEY,
  name TEXT,
  creationDate TEXT,
  state TEXT,
  note TEXT,
  idPoint INTEGER
  )''');

    await db.execute('''CREATE TABLE $recipientsTable 
  (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  recipientName TEXT,
  barcode TEXT,
  familyCount INTEGER,
  birthday TEXT,
  workFor TEXT,
  passportNum INTEGER,
  socialState TEXT,
  residentType TEXT,
  recordID INTEGER,
  isReceive INTEGER,
  listId INTEGER,
  image TEXT,
  phoneNum INTEGER
  
  )'''); //FOREIGN KEY (listId) REFERENCES $listTable (id) remove relation

  }

  Future<void> resetDatabase() async {
  // Close any open connections to the database.
  // await (await openDatabase(path)).close();

  // Delete the database file from the device or emulator.
  var documentDirectory = await getDatabasesPath();
  _path = join(documentDirectory, dbName);
  await databaseFactory.deleteDatabase(_path!);

}
}
