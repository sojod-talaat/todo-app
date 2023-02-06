import 'package:flutter/cupertino.dart';
import 'package:todo_app/moduels/archcive-task.dart';
import 'package:todo_app/moduels/done-task.dart';
import 'package:todo_app/moduels/new_task.dart';

import '../database/sq_helper.dart';

class AppCubit extends ChangeNotifier {
  AppCubit() {
    SqHelper.sqHelper.createDataBase();
    SqHelper.sqHelper.getDataFromDataBase();
  }
  int currentindex = 0;
  List<Widget> screen = [
    const NewTask(),
    const DonePage(),
    const ArchivePage()
  ];
  List<String> appbartitlle = ["New Tasks", "Done Tasks", "Archive Tasks"];
  changeBottomNavBar(int index) {
    currentindex = index;
    notifyListeners();
  }

  insertIntoDataBase(String title, String date, String time) async {
    await SqHelper.sqHelper.insertInDatabase(title, date, time);
    getDataFromDataBase();
    notifyListeners();
  }

  void getDataFromDataBase() async {
    await SqHelper.sqHelper.getDataFromDataBase();
    notifyListeners();
  }

  update(String status, int id) async {
    await SqHelper.sqHelper.update(status, id);
    getDataFromDataBase();
    notifyListeners();
  }

  delete(String id) async {
    await SqHelper.sqHelper.delate(id);
    getDataFromDataBase();
    notifyListeners();
  }
}
