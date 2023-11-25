import 'package:flutter/material.dart';
import 'package:flutter_task_management_software/provider/service_provider.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasktodoData = ref.watch(fetchDataProvider);
    return tasktodoData.when(
        data: (tasktodoData) {
          final getCategoryColor = tasktodoData[getIndex].category;
          Color categoryColor = Colors.white;

          switch (getCategoryColor) {
            case 'Education':
              categoryColor = Colors.red;
              break;
            case 'Work':
              categoryColor = Colors.yellow.shade600;
              break;
            case 'Personal':
              categoryColor = Colors.blue.shade800;
              break;
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            tasktodoData[getIndex].titleTask,
                            maxLines: 1,
                            style: TextStyle(
                                decoration: tasktodoData[getIndex].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          subtitle: Text(
                            tasktodoData[getIndex].description,
                            maxLines: 1,
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: CircleBorder(),
                              value: tasktodoData[getIndex].isCompleted,
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(
                                      tasktodoData[getIndex].docID, value),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -12),
                          child: Container(
                              child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  Text("Today"),
                                  Gap(12),
                                  Text(tasktodoData[getIndex].timeTask)
                                ],
                              )
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(
              child: Text(stackTrace.toString()),
            ),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }
}
