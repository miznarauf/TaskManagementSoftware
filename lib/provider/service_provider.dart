import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_management_software/services/tasktodo_service.dart';

final serviceProvider = StateProvider<TaskTodoService>((ref) {
  return TaskTodoService();
});
