import 'package:flutter/cupertino.dart';
import 'package:ieee_flutter_firebase/AppState.dart';
import 'package:ieee_flutter_firebase/Network/UserService.dart';
import 'package:ieee_flutter_firebase/model/UserModel.dart';

class UserProvider with ChangeNotifier{

  APPSTATE appstate;
  List<UserModel> userModel;
  UserService userService;
  String text;

  UserProvider(){
    userService = new UserService();
    userModel = new List();
    getAllUsersWithProvider();
  }

  Future<List<UserModel>> getAllUsersWithProvider() async{
    appstate = APPSTATE.LOADING;
    notifyListeners();
    userModel = await userService.getAllUsers();
    appstate = APPSTATE.DONE;
    notifyListeners();
  }

  changeText(String a){
    text = a;
    notifyListeners();
  }



}