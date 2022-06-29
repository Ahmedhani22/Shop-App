import 'package:flutter/material.dart';
import 'package:flutter2/shared/component/components.dart';
import 'package:flutter2/shared/component/constance.dart';
import 'package:flutter2/shared/cubit/cubit.dart';
import 'package:flutter2/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: ((context,  state) {
          if(state is AppInsertDataBaseState)
            {
              Navigator.pop(context);
            }
        }),
        builder: ((context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              title: Text(
                '${cubit.titles[cubit.currentIndex]}',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate())
                  {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                    );
                    // insertToDatabase(
                    //   title: titleController.text,
                    //   date: dateController.text,
                    //   time: timeController.text,
                    //  ).then((value) {
                    //
                    //   Navigator.pop(context);
                    //   isBottomSheetShown = false;
                    //    setState(() {
                    // fabIcon = Icons.edit;
                    //    });
                    //  });
                  }
                } else {
                  ScaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ' title must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                defaultFormField(
                                  OnTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context).toString());
                                    });
                                  },
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ' time must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'task time ',
                                  prefix: Icons.timelapse_rounded,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                defaultFormField(
                                  OnTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-12-31'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                      print(DateFormat.yMMMd().format(value));
                                    });
                                  },
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return ' date must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'task date ',
                                  prefix: Icons.date_range,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      ).closed
                      .then((value) {
                    cubit.ChangeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });

                  cubit.ChangeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 5.0,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline_rounded),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: 'Archived',
                ),
              ],
            ),
            body: cubit.screen[cubit.currentIndex],
          );
        }),
      ),
    );
  }

//Future<String> getName() async {
//  return 'Ahmed hani';
//}

}
