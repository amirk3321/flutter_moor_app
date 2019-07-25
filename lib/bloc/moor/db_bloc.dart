import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_moor_db/bloc/moor/bloc.dart';
import '../../repository/repository.dart';

class DbBloc extends Bloc<DbEvent, DbState> {

  final Repository _repository;

  DbBloc({Repository repository})
  :assert(repository!=null),
  _repository=repository;

  @override
  DbState get initialState => InitialState();

  @override
  Stream<DbState> mapEventToState(
    DbEvent event,
  ) async* {
    if (event is InsertEvent){
      yield* _mapInsertEventToState(event);
    }else if (event is TaskAllFetch){
     yield* _mapTaskAllFetchToState();
    }else if (event is DeleteEvent){
      yield* _mapDeleteEventToState(event);
    }else if(event is UpdateEvent){
      yield* _mapUpdateEventToState(event);
    }
  }

 Stream<DbState> _mapInsertEventToState(InsertEvent event) async*{
    await _repository.insertTasks(event.task);
 }

 Stream<DbState> _mapTaskAllFetchToState() async*{
   yield LoadingState();
    try{

      final tasks =await _repository.getAllTasks();

      yield LoadedState(task: tasks);
    }catch(_){
      yield ErrorState();
    }
  }

  Stream<DbState> _mapDeleteEventToState(DeleteEvent event)  async*{
    await _repository.deleteTasks(event.task);
  }

  Stream<DbState> _mapUpdateEventToState(UpdateEvent event)  async*{
    await _repository.updateTasks(event.task);
  }
}
