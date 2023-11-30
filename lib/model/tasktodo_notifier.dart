import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_management_software/model/tasktodo_model.dart';
import 'package:flutter_task_management_software/provider/service_provider.dart';
import 'package:flutter_task_management_software/services/tasktodo_service.dart';

class TaskTodoNotifier extends StateNotifier<List<TaskTodoModel>> {
  TaskTodoNotifier() : super([]);

  void addTask(TaskTodoModel task) {
    state = [...state, task];
  }

  void updateTask(String docId, bool valueUpdated) {
    state = state.map((task) {
      if (task.docID == docId) {
        task.isCompleted = valueUpdated;
      }
      return task;
    }).toList();
  }

  void deleteTask(String docId) {
    state = state.where((task) => task.docID != docId).toList();
  }
}

final taskTodoNotifierProvider =
StateNotifierProvider<TaskTodoNotifier, List<TaskTodoModel>>(
      (ref) => TaskTodoNotifier(),
);