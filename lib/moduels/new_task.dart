import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/bloc.dart';

import 'package:todo_app/component/task_widget.dart';
import 'package:todo_app/database/sq_helper.dart';

class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppCubit>(builder: (context, provider, x) {
      return SqHelper.sqHelper.newtasks.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Not found  Task to do yet!'),
                  Icon(Icons.menu),
                ],
              ),
            )
          : ListView.separated(
              itemCount: SqHelper.sqHelper.newtasks.length,
              separatorBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 9,
                );
              },
              itemBuilder: (context, index) {
                return buildTaskWidget(
                    SqHelper.sqHelper.newtasks[index], context);
              });
    });
  }
}
