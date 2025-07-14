import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SecondaryControlsWidget extends StatelessWidget {
  final bool isShuffleOn;
  final bool isRepeatOn;
  final bool isLiked;
  final bool isDownloaded;
  final VoidCallback onShuffle;
  final VoidCallback onRepeat;
  final VoidCallback onLike;
  final VoidCallback onQueue;
  final VoidCallback onShare;
  final VoidCallback onLyrics;

  const SecondaryControlsWidget({
    super.key,
    required this.isShuffleOn,
    required this.isRepeatOn,
    required this.isLiked,
    required this.isDownloaded,
    required this.onShuffle,
    required this.onRepeat,
    required this.onLike,
    required this.onQueue,
    required this.onShare,
    required this.onLyrics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First row - main controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildControlButton(
              icon: 'shuffle',
              isActive: isShuffleOn,
              onTap: onShuffle,
            ),
            _buildControlButton(
              icon: isLiked ? 'favorite' : 'favorite_border',
              isActive: isLiked,
              onTap: onLike,
            ),
            _buildControlButton(
              icon: 'repeat',
              isActive: isRepeatOn,
              onTap: onRepeat,
            ),
            _buildControlButton(
              icon: 'queue_music',
              isActive: false,
              onTap: onQueue,
            ),
            _buildControlButton(
              icon: 'share',
              isActive: false,
              onTap: onShare,
            ),
          ],
        ),

        SizedBox(height: 2.h),

        // Second row - additional options
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildControlButton(
              icon: 'lyrics',
              isActive: false,
              onTap: onLyrics,
            ),
            if (isDownloaded)
              _buildControlButton(
                icon: 'download_done',
                isActive: true,
                onTap: () {},
              ),
            _buildControlButton(
              icon: 'timer',
              isActive: false,
              onTap: () {
                // Handle sleep timer
              },
            ),
            _buildControlButton(
              icon: 'high_quality',
              isActive: false,
              onTap: () {
                // Handle audio quality
              },
            ),
            _buildControlButton(
              icon: 'cast',
              isActive: false,
              onTap: () {
                // Handle casting
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required String icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10.w,
        height: 10.w,
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryGreen.withValues(alpha: 0.2)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: icon,
            color: isActive
                ? AppTheme.primaryGreen
                : AppTheme.darkTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
        ),
      ),
    );
  }
}
