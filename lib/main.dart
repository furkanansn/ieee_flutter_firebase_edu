import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ieee_flutter_firebase/Provider/UserProvider.dart';
import 'package:ieee_flutter_firebase/UI/UsersPage.dart';
import 'package:provider/provider.dart';

import 'UI/AddTodoPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<UserProvider>(
        builder: (context, child) => UsersPage(),
        create:(context) => UserProvider() ,
      ),
    );
  }
}

