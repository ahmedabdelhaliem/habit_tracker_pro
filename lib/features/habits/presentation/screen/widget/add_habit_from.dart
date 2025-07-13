import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddHabitForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;

  const AddHabitForm({super.key, required this.titleController, required this.descController});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(height: 20.h),
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Habit Title',
            labelStyle: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            prefixIcon: Icon(Icons.title, color: colorScheme.primary),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
        SizedBox(height: 20.h),
        TextFormField(
          controller: descController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Description',
            labelStyle: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            prefixIcon: Icon(Icons.description, color: colorScheme.primary),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}
