//import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_management_software/widget/card_todo_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'comman/show_modal.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: _buildTheme(Brightness.light),
        debugShowCheckedModeBanner: false,
        title: 'Task Management Software',
        home: const HomePage(),
      ),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
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
                itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      CardTodoListWidget())
            ],
          ),
        ),
      ),
    );
  }
}
