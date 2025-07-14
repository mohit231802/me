import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QueueBottomSheetWidget extends StatefulWidget {
  final List<Map<String, dynamic>> queue;
  final Function(int oldIndex, int newIndex) onReorder;
  final Function(int songId) onSongTap;

  const QueueBottomSheetWidget({
    super.key,
    required this.queue,
    required this.onReorder,
    required this.onSongTap,
  });

  @override
  State<QueueBottomSheetWidget> createState() => _QueueBottomSheetWidgetState();
}

class _QueueBottomSheetWidgetState extends State<QueueBottomSheetWidget> {
  late List<Map<String, dynamic>> _queue;

  @override
  void initState() {
    super.initState();
    _queue = List.from(widget.queue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 10.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.darkTheme.colorScheme.onSurfaceVariant
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          _buildHeader(),

          // Queue list
          Expanded(
            child: _buildQueueList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Playing Queue',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.darkTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${_queue.length} songs',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueList() {
    return ReorderableListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      itemCount: _queue.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = _queue.removeAt(oldIndex);
          _queue.insert(newIndex, item);
        });
        widget.onReorder(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final song = _queue[index];
        final isCurrentSong = song["isPlaying"] as bool;

        return Container(
          key: ValueKey(song["id"]),
          margin: EdgeInsets.only(bottom: 1.h),
          child: _buildQueueItem(song, isCurrentSong, index),
        );
      },
    );
  }

  Widget _buildQueueItem(
      Map<String, dynamic> song, bool isCurrentSong, int index) {
    return GestureDetector(
      onTap: () {
        widget.onSongTap(song["id"] as int);
      },
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isCurrentSong
              ? AppTheme.primaryGreen.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isCurrentSong
              ? Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3))
              : null,
        ),
        child: Row(
          children: [
            // Album art
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomImageWidget(
                imageUrl: song["albumArt"] as String,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 3.w),

            // Song info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song["title"] as String,
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: isCurrentSong
                          ? AppTheme.primaryGreen
                          : AppTheme.darkTheme.colorScheme.onSurface,
                      fontWeight:
                          isCurrentSong ? FontWeight.w600 : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    song["artist"] as String,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Duration and controls
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  song["duration"] as String,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isCurrentSong)
                      CustomIconWidget(
                        iconName: 'graphic_eq',
                        color: AppTheme.primaryGreen,
                        size: 5.w,
                      ),
                    SizedBox(width: 2.w),
                    CustomIconWidget(
                      iconName: 'drag_handle',
                      color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
                      size: 5.w,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
