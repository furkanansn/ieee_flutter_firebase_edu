
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ieee_flutter_firebase/model/TodoModel.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
CollectionReference _collectionReference = _firestore.collection("todo");

class TodoService{

  Future<void> postDocument(TodoModel todoModel){
    todoModel.isDelete = false;
    return _collectionReference.doc().set(todoModel.toJson());
  }

  Future<void> deleteDocument(TodoModel todoModel){
    todoModel.isDelete = true;
    return _collectionReference.doc(todoModel.id).update(todoModel.toJson());
  }

  Stream<List<TodoModel>> getAllTodos(){
      return _collectionReference
          .where("isDelete", isEqualTo: false)
          .snapshots(includeMetadataChanges: true)
          .map((event) => event.docs.map((e) => TodoModel.fromJson(e)).toList());
  }

  Stream<List<TodoModel>> getDeletedTodos(){
    return _collectionReference
        .where("isDelete", isEqualTo: true)
        .snapshots(includeMetadataChanges: true)
        .map((event) => event.docs.map((e) => TodoModel.fromJson(e)).toList());
  }

}