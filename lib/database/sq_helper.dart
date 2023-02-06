import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class SqHelper {
  static SqHelper sqHelper = SqHelper();
  Database? database;
  List<Map> newtasks = [];
  List<Map> archiveTask = [];
  List<Map> doneTask = [];
  createDataBase() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                'CREATE TABLE Task (id INTEGER PRIMARY KEY, tasktitlle TEXT, date TEXT, time TEXT,status TEXT)')
            .then((value) {})
            .catchError((onError) {});
      },
      onOpen: (db) {
        log('databasw created');
      },
    ).then((value) {
      database = value;
    });
  }

  // insert
  insertInDatabase(String title, String date, String time) {
    return database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO task(tasktitlle,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        log('inserted record');
      }).catchError((onError) {});
    });
  }

  /// retrive
  getDataFromDataBase() async {
    archiveTask = [];
    doneTask = [];
    newtasks = [];
    await database!.rawQuery("SELECT *FROM task").then((value) {
      for (var element in value) {
        if (element["status"] == 'Archive') {
          archiveTask.add(element);
        } else if (element["status"] == "new") {
          newtasks.add(element);
        } else {
          doneTask.add(element);
        }
      }
    });
  }

  //// update
  update(String status, int id) async {
    await database!
        .rawUpdate('UPDATE task SET status = ? WHERE id = ?', [status, "$id"]);
  }

  delate(String id) async {
    await database!.rawDelete('DELETE FROM task WHERE id = ? ', [id]);
  }
}
