import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProgressBarWidget extends StatefulWidget {
  final double currentPosition;
  final String currentTime;
  final String totalTime;
  final ValueChanged<double> onSeek;

  const ProgressBarWidget({
    super.key,
    required this.currentPosition,
    required this.currentTime,
    required this.totalTime,
    required this.onSeek,
  });

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  bool _isDragging = false;
  double _dragValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
            activeTrackColor: AppTheme.primaryGreen,
            inactiveTrackColor: AppTheme.neutralGray.withValues(alpha: 0.3),
            thumbColor: AppTheme.primaryGreen,
            overlayColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: _isDragging ? _dragValue : widget.currentPosition,
            onChanged: (value) {
              setState(() {
                _isDragging = true;
                _dragValue = value;
              });
            },
            onChangeEnd: (value) {
              setState(() {
                _isDragging = false;
              });
              widget.onSeek(value);
            },
            min: 0.0,
            max: 1.0,
          ),
        ),

        SizedBox(height: 1.h),

        // Time indicators
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.currentTime,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                widget.totalTime,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
