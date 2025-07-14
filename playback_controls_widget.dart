import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PlaybackControlsWidget extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PlaybackControlsWidget({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Previous button
        _buildControlButton(
          icon: 'skip_previous',
          size: 10.w,
          onTap: onPrevious,
        ),

        // Play/Pause button
        GestureDetector(
          onTap: onPlayPause,
          child: Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: isPlaying ? 'pause' : 'play_arrow',
                color: AppTheme.pureBlack,
                size: 10.w,
              ),
            ),
          ),
        ),

        // Next button
        _buildControlButton(
          icon: 'skip_next',
          size: 10.w,
          onTap: onNext,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required String icon,
    required double size,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.darkTheme.colorScheme.onSurface,
            size: size,
          ),
        ),
      ),
    );
  }
}
