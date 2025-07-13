import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StreakCounter extends StatelessWidget {
  final int streak;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const StreakCounter({
    super.key,
    required this.streak,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Current Streak: $streak Days',
            style: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.red),
                onPressed: onDecrement,
                tooltip: 'Decrease Streak',
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.green),
                onPressed: onIncrement,
                tooltip: 'Increase Streak',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
