
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import './bloc/moor/bloc.dart';
import './bloc/delegate/simple_delegate.dart';
import './repository/repository.dart';
import './ui/home_page.dart';

void main() {

  BlocSupervisor.delegate=SimpleDelegate();
  runApp(myApp());
}


class myApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>myAppState();
}

class myAppState extends State<myApp>{
  Repository _repository = Repository();
  DbBloc _bloc;

  @override
  void initState() {
    _bloc=DbBloc(repository: _repository);
    _bloc.dispatch(TaskAllFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: BlocProvider(
        builder: (_) => _bloc,
        child: HomePage(),
      )
    );
  }
}