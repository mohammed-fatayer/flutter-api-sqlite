import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Students {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDB();
      return _db;
    } else {
      return _db;
    }
  }

  intialDB() async {
    String databasepass = await getDatabasesPath();

    String path = join(databasepass, "Students.db");
    Database db = await openDatabase(path,
        onCreate: _onCreat, version: 4, onUpgrade: _onUpgrade);

    return db;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    removeDatabase();
    print("onUpgrade =====================================");
  }

  _onCreat(Database db, int version) async {
    await db.execute(''' CREATE TABLE "Students"(
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "adress" TEXT NOT NULL,
      "age" INTEGER NOT NULL,
      "department" TEXT NOT NULL,
      "email" TEXT NOT NULL,
      "name" TEXT NOT NULL
    )''');

    print("database created =============================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    for (var i = 0; i < response.length; i++) {
      print(response[i]);
    }

    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  removeDatabase() async {
    String databasepass = await getDatabasesPath();
    String path = join(databasepass, "Students.db");
    await deleteDatabase(path);
    print("database deleted");
  }
}
