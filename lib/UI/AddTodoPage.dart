import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieee_flutter_firebase/Network/TodoService.dart';
import 'package:ieee_flutter_firebase/UI/AllTodosPage.dart';
import 'package:ieee_flutter_firebase/model/TodoModel.dart';

class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _key = GlobalKey<FormState>();

  TodoModel todoModel = new TodoModel();
  TodoService todoService = new TodoService();

  bool silinmeyenleriGoster = true;
  bool silinenleriGoster = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _key,
          child: ListView(

              children: [
            TextFormField(
              onSaved: (newValue) {
                todoModel.title = newValue;
              },
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              onSaved: (newValue) {
                todoModel.value = int.parse(newValue);
              },
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              onSaved: (newValue) {
                todoModel.message = newValue;
              },
              keyboardType: TextInputType.text,
            ),
            CupertinoButton.filled(
                child: Text("Save"),
                onPressed: () {
                  // _key.currentState.save();
                  FormState formState = _key.currentState;
                  formState.save();
                  addTodo();
                }),
            SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                  onTap: (){
                    setState(() {
                      silinmeyenleriGoster = !silinmeyenleriGoster;
                    });
                  },
                  child: Text("Silinmeyenler")),
            ),
            (silinmeyenleriGoster == false) ?
            StreamBuilder<List<TodoModel>>(
              stream: todoService.getAllTodos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: () async {
                          todoService.deleteDocument(snapshot.data[index]);
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data[index].title),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(snapshot.data[index].value.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data[index].message),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return CupertinoActivityIndicator();
              },
            )
            :
                Container(),
            Center(
              child: InkWell(
                  onTap: (){
                    setState(() {
                      silinenleriGoster = !silinenleriGoster;
                    });

                  },
                  child: Text("Silinenler")),
            ),
                (silinenleriGoster == false) ?
            StreamBuilder<List<TodoModel>>(
              stream: todoService.getDeletedTodos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(snapshot.data[index].title),
                            Text(snapshot.data[index].value.toString()),
                            Text(snapshot.data[index].message)
                          ],
                        ),
                      );
                    },
                  );
                }
                return CupertinoActivityIndicator();
              },
            )
                    :
                    Container()
          ])),
    );
  }

  addTodo() async {
    await todoService.postDocument(todoModel);
  }

  deleteTodo() async {
    await todoService.deleteDocument(todoModel);
  }
}
