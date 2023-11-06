import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/theme/core.theme.colors.dart';
import 'package:testemundowap/core/widgets/input/checkbox.task.field.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key, required this.taskList, required this.onRefresh});

  final List<Task> taskList;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        return RefreshIndicator(
          backgroundColor: AppColors.lightGrey,
          color: AppColors.white,
          onRefresh: onRefresh,
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return CheckBoxTaskField(task: taskList[i]);
            },
          ),
        );
      }),
    );
  }
}
