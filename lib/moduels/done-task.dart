import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/bloc.dart';
import 'package:todo_app/component/task_widget.dart';
import 'package:todo_app/database/sq_helper.dart';

class DonePage extends StatelessWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppCubit>(builder: (context, provider, x) {
      return ListView.separated(
          itemCount: SqHelper.sqHelper.doneTask.length,
          separatorBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 9,
            );
          },
          itemBuilder: (context, index) {
            return buildTaskWidget(SqHelper.sqHelper.doneTask[index], context);
          });
    });
  }
}
