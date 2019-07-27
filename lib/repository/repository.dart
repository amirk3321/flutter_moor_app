import '../db/moor_database.dart';


//single source of truth
class Repository{


  //AppDatabase instance
  TaskDao _dao =TaskDao(AppDatabase());


  Future<List<Task>> getAllTasks() => _dao.getAllTasks();

  Future<List<Task>> getAllCompletedTasks() => _dao.getAllCompletedTasks();

  Future insertTasks(Task task) => _dao.insertTask(task);

  Future updateTasks(Task task) => _dao.updateTask(task);

  Future deleteTasks(Task task) => _dao.deleteTask(task);



}