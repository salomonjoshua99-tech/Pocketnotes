import 'package:flutter/material.dart';

class DueDatePickerButton extends StatelessWidget {
  const DueDatePickerButton({super.key, required this.date, required this.onChanged});

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        onPressed: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) onChanged(picked);
        },
        icon: const Icon(Icons.calendar_today_outlined, size: 17),
        label: Text('${date.month}/${date.day}/${date.year}'),
      );
}
