import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/component/components.dart';
import 'package:todo/shared/cubit/app_cubit.dart';
import 'package:todo/shared/cubit/states.dart';
class DoneTask extends StatefulWidget {
  const DoneTask({Key? key}) : super(key: key);

  @override
  _DoneTaskState createState() => _DoneTaskState();
}

class _DoneTaskState extends State<DoneTask> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var tasks=AppCubit.get(context).doneTasks;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) =>
              buildTaskItem(tasks[index],context),
        );
      },
    );
  }


}
