import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/pages/task/task.binding.dart';

class CheckBoxTaskField extends StatefulWidget {
  const CheckBoxTaskField({super.key, required this.task, this.check});

  final FutureOr<void> Function(bool? value)? check;

  final Task task;
  @override
  State<CheckBoxTaskField> createState() => _CheckBoxTaskFieldState();
}

class _CheckBoxTaskFieldState extends State<CheckBoxTaskField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ExpansionTile(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(TaskBinding.route, arguments: widget.task.id);
          },
          icon: const Icon(Icons.edit),
        ),
        title: Text(widget.task.taskName),
        subtitle: Text(widget.task.description),
        children: <Widget>[
          Column(
            children: widget.task.fields
                .map(
                  (e) => ListTile(
                      title: Text(e.label),
                      subtitle: Text(e.fieldType),
                      iconColor:
                          e.completed == true ? Colors.green : Colors.red,
                      trailing: e.completed == true
                          ? const Icon(Icons.check)
                          : const Icon(Icons.cancel),
                      leading: Checkbox(
                          value: e.completed ?? false,
                          onChanged: widget.check)),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
