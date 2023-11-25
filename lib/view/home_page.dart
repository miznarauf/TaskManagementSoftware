import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_management_software/comman/show_modal.dart';
import 'package:flutter_task_management_software/provider/service_provider.dart';
import 'package:flutter_task_management_software/widget/card_todo_widget.dart';
import 'package:gap/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasktodoData = ref.watch(fetchDataProvider);


    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber.shade200,
                radius: 25,
                child: Image.asset('assets/red.png'),
              ),
              title: Text(
                'Hello I\'m',
                style: GoogleFonts.openSans(
                  textStyle:
                      TextStyle(color: Colors.grey.shade400, letterSpacing: .5),
                ),
              ),
              subtitle: const Text('Syed Muhammad Fraz',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black))),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.calendar),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.bell),
                ),
              ]),
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Task',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Friday, 17 Nov',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD5E8FA),
                        elevation: 0,
                        foregroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => AddNewTaskModal()),
                    child: const Text('+ New Task',
                        style: TextStyle(color: Colors.grey)),
                  ),

                  // Card list task
                ],
              ),
              Gap(20),
              ListView.builder(
                  itemCount: tasktodoData.value!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      CardTodoListWidget(getIndex: index))
            ],
          ),
        ),
      ),
    );
  }
}
