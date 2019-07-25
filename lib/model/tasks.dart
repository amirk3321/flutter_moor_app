
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';


/*optional : The default data class 'Tasks' would now be YourNameComeHere
@DataClassName("YourNameComeHere")*/
class Tasks extends Table {
  //automatically set primary key
  IntColumn get id => integer().autoIncrement()();

  //if the given condition is not happy the task will not
  //be inserted into db and thrown an exception latter we
  //will catch this error and show error to user
  TextColumn get name => text().withLength(min: 1, max: 25)();

  //DateTime is not supported by SQLite
  //Moor converts it to and from UNIX seconds
  DateTimeColumn get dueDate => dateTime().nullable()();

  //as will boolean not supported Moor converts them to integers
  //Default value specified by Constant
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

