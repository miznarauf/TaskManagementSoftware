import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_task_management_software/model/tasktodo_model.dart';

class TaskTodoService{
  final tasktodoCollection=FirebaseFirestore.instance.collection("TaskManagementApp");

  void addNewTask(TaskTodoModel model){
    tasktodoCollection.add(model.toMap());
  }

}