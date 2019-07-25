import 'package:equatable/equatable.dart';
import 'package:flutter_moor_db/db/moor_database.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DbEvent extends Equatable {
  DbEvent([List props = const []]) : super(props);
}
//notify the bloc if data exists retrive
class StartAppEvent extends DbEvent{
  @override
  String toString() => "StartAppEvent";
}


//notify the bloc insert record into db
class InsertEvent extends DbEvent{
  Task task;
  InsertEvent({this.task}) : super([task]);
  @override
  String toString() => "InsertEvent - Task : $task";
}

//notify the bloc update task
class UpdateEvent extends DbEvent{
  Task task;
  UpdateEvent({this.task}) :super([task]);

  @override
  String toString() => "UpdateEvent";
}

//notify the bloc delete the task form the db
class DeleteEvent extends DbEvent{
  Task task;
  DeleteEvent({this.task}) : super([task]);
  @override
  String toString() => "DeleteEvent - task $task";
}

//notify the bloc watch the db
class TaskWatchEvent{
  @override
  String toString() => "TaskWatchEvent";
}

//notify the bloc fetch all the record form db
class TaskAllFetch extends DbEvent{

  @override
  String toString() => "TaskAllFetch";
}