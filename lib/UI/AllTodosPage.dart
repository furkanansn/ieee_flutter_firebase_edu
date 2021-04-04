import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieee_flutter_firebase/Network/TodoService.dart';
import 'package:ieee_flutter_firebase/model/TodoModel.dart';

class AllTodosPage extends StatefulWidget {
  @override
  _AllTodosPageState createState() => _AllTodosPageState();
}

class _AllTodosPageState extends State<AllTodosPage> {

  TodoService todoService = new TodoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<TodoModel>>(
        stream: todoService.getAllTodos(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Text(snapshot.data[index].title),
                    Text(snapshot.data[index].message),
                  ],
                ),
              );
            },);
          }
          return CupertinoActivityIndicator();
        },
      ),
    );
  }
}
