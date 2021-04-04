import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ieee_flutter_firebase/model/CommentDetailModel.dart';
import 'package:ieee_flutter_firebase/model/UserModel.dart';

class UserService{

  Future<List<UserModel>> getAllUsers()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    return  (jsonDecode(response.body) as List)
        .map((e) => UserModel.fromJson(e)).toList();
  }

  Future<CommentDetail> getCommentDetail()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    return CommentDetail.fromJson(jsonDecode(response.body));
  }

  Future<CommentDetail> postCommentDetail(var comment,var title)async{
    final response = await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts/")
    ,body: {
      "comment" : comment,
      "title" : title
        });
    return CommentDetail.fromJson(jsonDecode(response.body));
  }

}