// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:habit_tracker/core/theme/app_text_styles.dart';
// import 'package:habit_tracker/features/habits/data/models/habit_model.dart';

// class EditHabitScreen extends StatefulWidget {
//   final HabitModel habit;

//   const EditHabitScreen({super.key, required this.habit});

//   @override
//   State<EditHabitScreen> createState() => _EditHabitScreenState();
// }

// class _EditHabitScreenState extends State<EditHabitScreen> {
//   late TextEditingController nameController;
//   late TextEditingController repetitionsController;
//   late String frequency;

//   final List<String> allowedFrequencies = ['يوميًا', 'أسبوعيًا'];

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.habit.name);
//     repetitionsController = TextEditingController(text: widget.habit.repetitions.toString());

//     frequency = allowedFrequencies.contains(widget.habit.frequency)
//         ? widget.habit.frequency
//         : allowedFrequencies.first;
//   }

//   void _saveChanges() async {
//     final name = nameController.text.trim();
//     final repetitions = int.tryParse(repetitionsController.text.trim()) ?? 1;

//     if (name.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى إدخال اسم العادة')));
//       return;
//     }

//     widget.habit
//       ..name = name
//       ..repetitions = repetitions
//       ..frequency = frequency;

//     await widget.habit.save();

//     Navigator.of(context).pop(); // ✅ رجوع بعد الحفظ
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0.r),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('اسم العادة', style: AppTextStyles.headline1),
//             SizedBox(height: 8.h),
//             TextFormField(
//               controller: nameController,
//               decoration: InputDecoration(border: OutlineInputBorder()),
//             ),
//             SizedBox(height: 16.h),
//             Text('عدد التكرارات اليومية', style: AppTextStyles.headline1),
//             SizedBox(height: 8.h),
//             TextFormField(
//               controller: repetitionsController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(border: OutlineInputBorder()),
//             ),
//             SizedBox(height: 16.h),
//             Text('نمط التكرار', style: AppTextStyles.headline1),
//             SizedBox(height: 8.h),
//             DropdownButtonFormField<String>(
//               value: frequency,
//               items: allowedFrequencies
//                   .map((f) => DropdownMenuItem(value: f, child: Text(f)))
//                   .toList(),
//               onChanged: (val) => setState(() => frequency = val!),
//               decoration: InputDecoration(border: OutlineInputBorder()),
//             ),
//             SizedBox(height: 24.h),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: _saveChanges,
//                 icon: Icon(Icons.save),
//                 label: Text('حفظ التعديلات'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
