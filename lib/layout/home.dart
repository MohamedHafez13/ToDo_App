import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/component/components.dart';
import 'package:todo/shared/cubit/app_cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                  "${AppCubit.get(context).titles[AppCubit.get(context).currentIndex]}"),
              // actions: [
              //   IconButton(
              //     icon:Icon(Icons.print) ,
              //     onPressed:(){
              //       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Print()));
              //     } ,
              //   )
              // ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(AppCubit.get(context).iconData),
              onPressed: () {
                if (AppCubit.get(context).isBottomSheet) {
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    setState(() {
                      AppCubit.get(context)
                          .insertToDatabase(
                        title: taskController.text,
                        date: dateController.text,
                        time: timeController.text,
                      )
                          .then((value) {
                        Navigator.pop(context);

                        AppCubit.get(context).changeBottomSheetState(
                            isOpen: false, icon: Icons.edit);
                      });
                    });
                  }
                } else {
                  AppCubit.get(context)
                      .changeBottomSheetState(isOpen: true, icon: Icons.add);

                  scaffoldKey.currentState!
                      .showBottomSheet((context) {
                    return Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            textFormField(
                                label: "Task Title",
                                controller: taskController,
                                textInputType: TextInputType.text,
                                hintText: "Task Title",
                                prefix: Icons.title,
                                validation: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Task Title must be not empty";
                                  }
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            textFormField(
                                label: "Task Date",
                                controller: dateController,
                                textInputType: TextInputType.datetime,
                                hintText: "Task Date",
                                prefix: Icons.calendar_today,
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate:
                                      DateTime.parse("2021-12-27"))
                                      .then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                validation: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Task Date must be not empty";
                                  }
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            textFormField(
                                label: "Task Time",
                                controller: timeController,
                                textInputType: TextInputType.datetime,
                                hintText: "Task Time",
                                prefix: Icons.timer,
                                onTap: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                validation: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Task Time must be not empty";
                                  }
                                }),
                          ],
                        ),
                      ),
                    );
                  })
                      .closed
                      .then((value) {
                    AppCubit.get(context).changeBottomSheetState(
                        isOpen: false, icon: Icons.edit);
                  });
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  label: "Tasks",
                  icon: Icon(Icons.menu),
                ),
                BottomNavigationBarItem(
                  label: "Done",
                  icon: Icon(Icons.done),
                ),
                BottomNavigationBarItem(
                  label: "Archived",
                  icon: Icon(Icons.archive),
                ),
              ],
            ),
            body:
            AppCubit.get(context).pages[AppCubit.get(context).currentIndex],
          );
        },
      ),
    );
  }
}
