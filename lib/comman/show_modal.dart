import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_management_software/constants/app_style.dart';
import 'package:flutter_task_management_software/model/tasktodo_model.dart';
import 'package:flutter_task_management_software/provider/radio_provider.dart';
import 'package:flutter_task_management_software/provider/date_time_provider.dart';
import 'package:flutter_task_management_software/provider/service_provider.dart';
import 'package:flutter_task_management_software/widget/TextField_widget.dart';
import 'package:flutter_task_management_software/widget/date_time_widget.dart';
import 'package:flutter_task_management_software/widget/radio_widget.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddNewTaskModal extends ConsumerWidget {
  AddNewTaskModal({Key? key}) : super(key: key);

  // Initializing variables
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);
    final dateProv = ref.watch(DateProvider);
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height * 0.80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text('New task Todo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Divider(
                thickness: 1.2,
                color: Colors.grey.shade200,
              ),
              const Gap(12),
              Text(
                'Title Task',
                style: AppStyle.headingOne,
              ),
              const Gap(6),
              TextFieldWidget(
                maxLines: 1,
                hintText: "Add Task Name",
                txtController: titleController,
              ),
              Gap(12),
              Text('Description', style: AppStyle.headingOne),
              Gap(6),
              TextFieldWidget(
                maxLines: 5,
                hintText: "Add Descriptions",
                txtController: descriptionController,
              ),
              Gap(12),
              Text(
                "Cateogry",
                style: AppStyle.headingOne,
              ),
              Gap(6),
              Row(
                children: [
                  Expanded(
                    child: RadioWidget(
                      categColor: Colors.red,
                      titleRadio: "EDU",
                      valueInput: 1,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 1),
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      categColor: Colors.yellow.shade600,
                      titleRadio: "WRK",
                      valueInput: 2,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 2),
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      categColor: Colors.blue.shade800,
                      titleRadio: "PER",
                      valueInput: 3,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 3),
                    ),
                  )
                ],
              ),
              //Date and time selection
              Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateTimeWidget(
                      titleText: "Date",
                      valueText: ref.watch(DateProvider),
                      iconSection: CupertinoIcons.calendar,
                      onTap: () async {
                        final getValue = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2025));

                        if (getValue != null) {
                          final format = DateFormat.yMd();
                          ref
                              .read(DateProvider.notifier)
                              .update((state) => format.format(getValue));
                        }
                      }),
                  Gap(22),
                  DateTimeWidget(
                    titleText: "Time",
                    valueText: ref.watch(TimeProvider),
                    iconSection: CupertinoIcons.clock,
                    onTap: () async {
                      final getTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      if (getTime != null) {
                        ref
                            .read(TimeProvider.notifier)
                            .update((state) => getTime.format((context)));
                      }
                    },
                  ),
                ],
              ),

              // Button Section
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(color: Colors.blue.shade800),
                          padding: EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () {
                        final getradioValue = ref.read(radioProvider);
                        String category = '';

                        switch (getradioValue) {
                          case 1:
                            category = "Education";
                            break;
                          case 2:
                            category = "Work";
                            break;
                          case 3:
                            category = "Personal";
                            break;
                        }

                        ref.read(serviceProvider).addNewTask(TaskTodoModel(
                            titleTask: titleController.text,
                            description: descriptionController.text,
                            category: category,
                            dateTask: ref.read(DateProvider),
                            timeTask: ref.read(TimeProvider),
                            isCompleted: false));

                        print("Data is saving...");

                        titleController.clear();
                        descriptionController.clear();
                        ref.read(radioProvider.notifier).update((state) => 0);
                        Navigator.pop(context);
                      },
                      child: Text('Create'),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
