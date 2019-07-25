import '../db/moor_database.dart';


//single source of truth
class Repository{


  //AppDatabase instance
  AppDatabase db=AppDatabase();


  Future<List<Task>> getAllTasks() => db.getAllTasks();

  Stream<List<Task>> getAllWatch() =>db.watchAllTasks();

  Future insertTasks(Task task) => db.insertTask(task);

  Future updateTasks(Task task) => db.updateTask(task);

  Future deleteTasks(Task task) => db.deleteTask(task);


}