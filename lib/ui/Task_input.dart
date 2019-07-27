

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moor_db/bloc/moor/bloc.dart';
import 'package:flutter_moor_db/db/moor_database.dart';

class InputTask extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InputTaskState();
}
class InputTaskState extends State<InputTask>{
  DateTime newTaskDate;
  TextEditingController controller;

  @override
  void initState() {
    controller=TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTextField(context),
          _buildDateButton(context),
        ],

      ),
    );
  }
  Expanded _buildTextField(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15  ,vertical: 5),
        decoration: BoxDecoration(color: Colors.grey[300],borderRadius:BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Insert task ',border: InputBorder.none,
          suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: (){

            if (controller.text.isNotEmpty){
              final _bloc = BlocProvider.of<DbBloc>(context);
              final task = Task(
                name: controller.text,
                dueDate: newTaskDate,
              );
              _bloc.dispatch(InsertEvent(task: task));
              _bloc.dispatch(TaskAllFetch());
              resetValuesAfterSubmit();
            }

        })),
        ),
      ),
    );
  }


  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today,color: Colors.purple,),
      onPressed: () async {
        newTaskDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      newTaskDate = null;
      controller.clear();
    });
  }
}