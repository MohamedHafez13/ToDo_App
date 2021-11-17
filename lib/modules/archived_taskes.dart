import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/component/components.dart';
import 'package:todo/shared/cubit/app_cubit.dart';
import 'package:todo/shared/cubit/states.dart';
class ArchivedTask extends StatefulWidget {
  const ArchivedTask({Key? key}) : super(key: key);

  @override
  _ArchivedTaskState createState() => _ArchivedTaskState();
}

class _ArchivedTaskState extends State<ArchivedTask> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var tasks=AppCubit.get(context).archivedTasks;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) =>
              buildTaskItem(tasks[index],context),
        );
      },
    );
  }
}