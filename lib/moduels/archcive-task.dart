import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/bloc.dart';

import 'package:todo_app/database/sq_helper.dart';

import '../component/task_widget.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppCubit>(builder: (context, provider, x) {
      return ListView.separated(
          itemCount: SqHelper.sqHelper.archiveTask.length,
          separatorBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 9,
            );
          },
          itemBuilder: (context, index) {
            return buildTaskWidget(
                SqHelper.sqHelper.archiveTask[index], context);
          });
    });
  }
}
