import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel{

  String id;
  String title;
  int value;
  String message;
  bool isDelete;

  TodoModel({this.id, this.title, this.value,this.isDelete,this.message});

  factory TodoModel.fromJson(DocumentSnapshot json)=> TodoModel(
    id : json.id,
    title : json.data()['title'] ?? "",
    value: json.data()['value'],
    isDelete: json.data()['isDelete'],
    message : json.data()['message'] ?? "");


  Map<String,dynamic> toJson()=>{
    "title" : title,
    "value": value,
    "isDelete" : isDelete,
    "message" : message
  };






}