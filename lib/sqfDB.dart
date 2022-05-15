import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = p.join(databasepath, 'note.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("================== Updated ===================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT , 
    "title" TEXT NOT NULL ,
    "note" TEXT NOT NULL ,
    "color" INTEGER NOT NULL
  )
 ''');
    print("================== Created ==================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
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

  deleteDatabaseFromDvice() async {
    String databasePath = await getDatabasesPath();
    String path = p.join(databasePath, "note.db");
    await deleteDatabase(path);
    print("================== Deleted ==================");
  }

// SELECT
// DELETE
// UPDATE
// INSERT

}

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' as p;

// class SQFDB {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialDB();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   intialDB() async {
//     String databasePath = await getDatabasesPath();
//     String path = p.join(databasePath, "note.db");
//     Database appDB = await openDatabase(path,
//         onCreate: _onCreate, onUpgrade: _onUpgrade, version: 1);
//   }

//   _onUpgrade(Database db, int oldVertion, int newVertion) async {
//     print(
//         " ================= Database And Tables Are Upgraded =================");
//   }

//   _onCreate(Database db, int vertion) async {
//     await db.execute('''
//     CREATE TABLE "notes"(
//       "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
//       "title" TEXT NOT NULL ,
//       "note" TEXT NOT NULL ,
//       "color" TEXT NOT NULL
//     )
// ''');
//     print(
//         " ================= Database And Tables Are Created =================");
//   }

//   getData(String sql) async {
//     Database? mydb = await db;
//     List<Map> result = await mydb!.rawQuery(sql);
//     return result;
//   }

//   deleteData(String sql) async {
//     Database? mydb = await db;
//     int result = await mydb!.rawDelete(sql);
//     return result;
//   }

//   insertData(String sql) async {
//     Database? mydb = await db;
//     int result = await mydb!.rawInsert(sql);
//     return result;
//   }

//   updateData(String sql) async {
//     Database? mydb = await db;
//     int result = await mydb!.rawUpdate(sql);
//     return result;
//   }

//   deleteDatabaseFromDvice() async {
//     String databasePath = await getDatabasesPath();
//     String path = p.join(databasePath, "note.db");
//     await deleteDatabase(path);
//   }
// }
