import 'package:flutter/material.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';

class CheckBoxTaskField extends StatefulWidget {
  const CheckBoxTaskField({super.key, required this.task});
  final Task task;
  @override
  State<CheckBoxTaskField> createState() => _CheckBoxTaskFieldState();
}

class _CheckBoxTaskFieldState extends State<CheckBoxTaskField> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.task.taskName),
      subtitle: Text(widget.task.description),
      children: <Widget>[
        Column(
          children: widget.task.fields
              .map(
                (e) => ListTile(
                    title: Text(e.label),
                    subtitle: Text(e.fieldType),
                    leading: Checkbox(value: e.isRequired, onChanged: null)),
              )
              .toList(),
        ),
      ],
    );
  }
}
