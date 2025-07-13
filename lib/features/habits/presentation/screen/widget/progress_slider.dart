import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressSlider extends StatelessWidget {
  final double progress;
  final ValueChanged<double> onChanged;

  const ProgressSlider({
    super.key,
    required this.progress,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          'Progress: ${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 16.sp,
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
          ),
          child: Slider(
            value: progress,
            onChanged: onChanged,
            min: 0,
            max: 1,
            divisions: 100,
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.primary.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}
