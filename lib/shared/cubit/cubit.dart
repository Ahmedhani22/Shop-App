import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/modules/todo_app/arch_tasks/arch_tasks_screen.dart';
import 'package:flutter2/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:flutter2/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:flutter2/shared/cubit/states.dart';
import 'package:flutter2/shared/network/local/cash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Map> tasks = [];
  late Database database;

  List<Widget> screen = [
    TasksScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];
  List<String> titles = [
    'Tasks',
    'Done',
    'Archive',
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBar());
  }

  void CreatdataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT , status TEXT )')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when creating table is : ${error}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        tasks = value;
        emit(AppGetOfDataBaseState());
      });
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO tasks (title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());

        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetOfDataBaseState());
        });
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future getDataFromDatabase(database) async {
    List<Map> tasks = await database.rawQuery('SELECT * FROM tasks ');
    print(tasks);
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void ChangeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void ChangaAppModa({bool ?fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.PutBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
