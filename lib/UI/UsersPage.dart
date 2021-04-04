import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieee_flutter_firebase/AppState.dart';
import 'package:ieee_flutter_firebase/Network/UserService.dart';
import 'package:ieee_flutter_firebase/Provider/UserProvider.dart';
import 'package:ieee_flutter_firebase/model/UserModel.dart';
import 'package:provider/provider.dart';



class UsersPage extends StatelessWidget {

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

   return Consumer<UserProvider>(builder: (context, value, child) {
      if(value.appstate == APPSTATE.LOADING){
        return Scaffold(body: Center(child: CupertinoActivityIndicator(),),);
      }
      else if(value.appstate == APPSTATE.DONE){
        return Scaffold(
          body: Form(
            key: _key,
            child: ListView(

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (newValue) {
                      value.changeText(newValue);
                    },
                  ),
                ),
                CupertinoButton.filled(child: Text("kaydet"), onPressed: () {
                  _key.currentState.save();
                },),
                Center(child: Text((value.text == null) ? "" : value.text),),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.userModel.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(value.userModel[index].name),
                            Text(value.userModel[index].username),
                            Text(value.userModel[index].email),
                            Text(value.userModel[index].phone),
                            Text(value.userModel[index].address.city),
                            Text(value.userModel[index].company.name),
                            Text(value.userModel[index].website),

                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }

      return CupertinoActivityIndicator();
    },);
  }
}
