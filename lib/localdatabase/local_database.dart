import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Attendance{
  static String attendanceTable = "AttendanceTable";
}

Future<Map<String, dynamic>> createTable({
  int? version,
}) async
{
  Directory directory = await getApplicationDocumentsDirectory();
  String path = join(directory.path, 'alpesh.db');
  // String path = join(directory.path, '$tableName.db');

  late Database database;
  bool tableExists = false;
  String? error;

  Future<bool> tableExistsCheck(Database db, String tableName) async {
    List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return tables.isNotEmpty;
  }

  try {
    database = await openDatabase(path, version: version ?? 1,
        onCreate: (Database db, int version) async {
          // Create tables
          try {

            bool tableExists = await tableExistsCheck(db, Attendance.attendanceTable);
            if (!tableExists) {

              debugPrint("🔥 onCreate triggered");
              // CREATE TABLE ${j.tableName}(

              await db.execute('''
              CREATE TABLE IF NOT EXISTS ${Attendance.attendanceTable}(
                tableId INTEGER PRIMARY KEY AUTOINCREMENT,
                Name INTEGER NULL
              )
            ''');
            }
            // print("alpesh make a &&&& created successfully is done ${tableName}");
          } catch (e) {
            print('Error creating table: $e');
            error = 'Error creating table: $e';
          }
        },
        onOpen: (db) async {

          // List<Map<String, dynamic>> tables = await db.rawQuery(
          //     "SELECT name FROM sqlite_master WHERE type='table' AND name='${Attendance.attendanceTable}'");
          // print("alpesh make a ****** onOpen successfully ${Attendance.attendanceTable}");
          // tableExists = tables.isNotEmpty;
        },
        onUpgrade: (db, oldVersion, newVersion) async {

          print("alpesh make a @@@@@@@ on upgrade");
          // Handle database upgrades
          // This is necessary if you plan to change the schema in future versions
          // For now, you can leave it empty or add any necessary upgrade logic
        });
  } catch (e) {
    error = 'Error opening database: $e';
  }

  print("database path is >> ${database} : ${tableExists} : $error");
  return {'database': database, 'tableExists': tableExists, 'error': error};
}

Future<void> addNewDataInLocal({required Map<String, dynamic> newCheckData}) async {

  try{
    Database db = await openExistingDatabase();
    newCheckData.removeWhere((key, value) => value == null);
    // Insert or replace the sanitized project data into the database
    await db.insert(
      Attendance.attendanceTable,
      newCheckData,
    );
    showTableData(tableName: Attendance.attendanceTable);
  }
  catch(e){
    print("addNewCheckInLocal error is  :${e.toString()}");
  }
}

Future<bool> updateCheckDetails({required String checkId,required Map<String,dynamic> updatedData}) async {
  Database db = await openExistingDatabase();

  try {

    await db.update(
      Attendance.attendanceTable,
      updatedData, // Provide the value you want to update with
      where: 'id = ?',
      whereArgs: [checkId],
    );

    return true;
  } catch (e) {
    print("updateCheckDetails exception ${e.toString()} tableName ${Attendance.attendanceTable}");
    // Return false to indicate update failure
    return false;
  }
}

Future<Database> openExistingDatabase() async {

  Directory directory = await getApplicationDocumentsDirectory();
  String path = join(directory.path, 'alpesh.db');

  try{
    Database database = await openDatabase(path);
    return database;
  }
  catch(e){
    print("database error ${e.toString()}");
    throw Exception(e);
  }
}

Future<void> showTableData({required String tableName,String? checkId}) async {
  Database db = await openExistingDatabase();
  try {
    // List<Map<String, dynamic>> tableData = await db.query(tableName,limit: 5,orderBy: 'tableId DESC',where: "id = ? ",whereArgs: [checkId]);
    List<Map<String, dynamic>> tableData = await db.query(tableName,/*limit: 5,*/orderBy: 'tableId DESC');

    if (tableData.isNotEmpty) {
      for (var project in tableData) {

        print('\n\n\n');
        print('---------$tableName Table--------------');
        print(project);
        print('---------$tableName Table--------------');
        print('\n\n\n');
      }
    }
    else{
      print('---------No data found in tableName : $tableName--------------');
    }
  } catch (e) {
    print("showTableData exception ${e.toString()} tableName $tableName");
  }
}


Future<bool> deleteCheckInImage({required String checkId, required int deletedImageId}) async {
  Database db = await openExistingDatabase();

  try {
    // Delete the image from the check images table
    await db.delete(
      Attendance.attendanceTable,
      where: 'check_id = ? AND id = ?',
      whereArgs: [checkId, deletedImageId],
    );
    return true;
  } catch (e) {
    print("deleteCheckInImage exception ${e.toString()} tableName ${Attendance.attendanceTable}");
    return false;
  }
}

Future<void> showALLTableField() async {
  try {
    Database db = await openExistingDatabase();
    List<Map<String, dynamic>> tables = await db.rawQuery("SELECT * FROM sqlite_master WHERE type='table'");

    for (var table in tables) {
      String tableName = table['name'];
      if (tableName == 'android_metadata') continue; // Skip system table

      print('🔷 Table Name: $tableName');

      List<Map<String, dynamic>> columns = await db.rawQuery("PRAGMA table_info($tableName)");

      for (var column in columns) {
        String columnName = column['name'];
        String columnType = column['type'];
        String isNullable = column['notnull'] == 0 ? 'YES' : 'NO';

        print('   🔹 Column: $columnName, Type: $columnType, Nullable: $isNullable');
      }

      print('------------');
    }
  } catch (e) {
    debugPrint("Error while showing table fields: $e");
  }
}
