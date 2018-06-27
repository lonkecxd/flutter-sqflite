import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_demo/models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var DB = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return DB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User"
            "(id integer primary key, username text, password text)"
    );
    print('TABLE CREATED!');
  }

  Future<int> saveUser(User user)async{
      var db_client = await db;
      int res = await db_client.insert("User", user.toMap());
      return res;
  }

  Future<int> deleteUser(User user)async{
    var db_client = await db;
    int res = await db_client.delete("User");
    return res;
  }
  
}
