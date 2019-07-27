library moor_database;

import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';
import '../model/tasks.dart';

part 'moor_database.g.dart';


//run below the command on your terminal
//flutter packages pub run build_runner watch, (build or watch)

@UseMoor(tables: [Tasks],daos: [TaskDao])
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


}


@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin{
  final AppDatabase db;
  TaskDao(this.db) : super (db);


  Future<List<Task>> getAllTasks() {
    return (select(tasks)
      ..orderBy(([
            (t) =>
            OrderingTerm(expression: t.dueDate,mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.name),
      ])
      )).get();
  }

  Future <List<Task>> getAllCompletedTasks() {
    return (select(tasks)
      ..orderBy(([
        (t) => OrderingTerm(expression: t.dueDate,mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.name),
      ]))
        ..where((t) => t.completed.equals(true))
    ).get();
  }


  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);

  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);

  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);

}
