library moor_database;

import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';
import '../model/tasks.dart';

part 'moor_database.g.dart';

//run below the command on your terminal
//flutter packages pub run build_runner watch, (build or watch)

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          //best for debugging
          logStatements: true,
        )));

  //
  @override
  int get schemaVersion => 1;


  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future insertTask(Task task) => into(tasks).insert(task);

  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);
}
