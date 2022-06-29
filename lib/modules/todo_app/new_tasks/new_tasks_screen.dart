import 'package:flutter/material.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/cubit/cubit.dart';


class TasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppCubit cubit= AppCubit.get(context);
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItems(cubit.tasks[index]),
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
      itemCount: cubit.tasks.length,
    );
  }
}
