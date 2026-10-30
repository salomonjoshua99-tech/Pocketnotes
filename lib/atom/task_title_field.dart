import 'package:flutter/material.dart';

class TaskTitleField extends StatelessWidget {
  const TaskTitleField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        maxLength: 120,
        decoration: const InputDecoration(
          labelText: 'Task',
          hintText: 'What needs doing?',
          border: OutlineInputBorder(),
        ),
      );
}
