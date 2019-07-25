import 'package:equatable/equatable.dart';
import 'package:flutter_moor_db/db/moor_database.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DbState extends Equatable {
  DbState([List props = const []]) : super(props);
}
//notify the bloc if there is no record exists show hint msg to the use to add
//some record
class InitialState extends DbState {}



//LoadingState notify the bloc and show CircularProgressIndicator
class LoadingState extends DbState{
  @override
  String toString() => "LoadingState";
}

//LoadedState notify the bloc to fetch all the form db and show in listView
class LoadedState extends DbState{
  List<Task> task;

  LoadedState({this.task}) :super([task]);

  @override
  String toString() => "LoadingState";
}

class ErrorState extends DbState{
  @override
  String toString() => "ErrorState";
}