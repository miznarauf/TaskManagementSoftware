import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_management_software/model/tasktodo_model.dart';
import 'package:flutter_task_management_software/services/tasktodo_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final serviceProvider = StateProvider<TaskTodoService>((ref) {
  return TaskTodoService();
});

final fetchDataProvider = StreamProvider<List<TaskTodoModel>>((ref) async* {
  try {
    final getData = FirebaseFirestore.instance
        .collection('TaskManagementApp')
        .get()
        .then((querySnapshot) {
      print("Number of documents: ${querySnapshot.docs.length}");
      return querySnapshot.docs
          .map((snapshot) {
        print("Document ID: ${snapshot.id}");
        print("Document data: ${snapshot.data()}");
        return TaskTodoModel.fromSnapshot(snapshot);
      })
           .toList();
    });
    print(getData);
    yield* getData.asStream();
  } catch (e) {
    print("Error fetching data: $e");
    // Handle the error as needed
  }
});

