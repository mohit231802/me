import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LibraryItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final int tabIndex;
  final bool isSelected;
  final bool isMultiSelectMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  const LibraryItemWidget({
    super.key,
    required this.item,
    required this.tabIndex,
    required this.isSelected,
    required this.isMultiSelectMode,
    required this.onTap,
    required this.onLongPress,
    required this.onSwipeRight,
    required this.onSwipeLeft,
  });

  String _getSubtitle() {
    switch (tabIndex) {
      case 0: // Recently Added
        return '${item["artist"]} • ${item["duration"]}';
      case 1: // Artists
        final songCount = item["songCount"] as int;
        return '$songCount song${songCount != 1 ? 's' : ''}';
      case 2: // Albums
        return '${item["artist"]} • ${item["year"]}';
      case 3: // Playlists
        final songCount = item["songCount"] as int;
        return '$songCount song${songCount != 1 ? 's' : ''}';
      case 4: // Downloaded
        return '${item["artist"]} • ${item["fileSize"]}';
      default:
        return '';
    }
  }

  String _getTitle() {
    return item["title"] ?? item["name"] ?? '';
  }

  Widget _buildLeadingWidget() {
    return Container(
      width: 14.w,
      height: 14.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            tabIndex == 1 ? 7.w : 2.w), // Circular for artists
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(tabIndex == 1 ? 7.w : 2.w),
            child: CustomImageWidget(
              imageUrl: item["imageUrl"] as String,
              width: 14.w,
              height: 14.w,
              fit: BoxFit.cover,
            ),
          ),
          if (isMultiSelectMode)
            Container(
              width: 14.w,
              height: 14.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(tabIndex == 1 ? 7.w : 2.w),
                color: isSelected
                    ? AppTheme.primaryGreen.withValues(alpha: 0.8)
                    : AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.8),
              ),
              child: Center(
                child: isSelected
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        size: 6.w,
                      )
                    : Container(
                        width: 5.w,
                        height: 5.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            width: 1.5,
                          ),
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrailingWidget() {
    if (isMultiSelectMode) {
      return SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tabIndex == 0 &&
            item["isDownloaded"] ==
                true) // Recently Added with download indicator
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: CustomIconWidget(
              iconName: 'download_done',
              color: AppTheme.primaryGreen,
              size: 4.w,
            ),
          ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'play':
                onSwipeRight();
                break;
              case 'add_to_playlist':
                // Handle add to playlist
                break;
              case 'remove':
                onSwipeLeft();
                break;
              case 'download':
                // Handle download
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'play',
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'play_arrow',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Text('Play'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'add_to_playlist',
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'playlist_add',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Text('Add to playlist'),
                ],
              ),
            ),
            if (tabIndex != 4) // Not in Downloaded tab
              PopupMenuItem<String>(
                value: 'download',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'download',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 5.w,
                    ),
                    SizedBox(width: 3.w),
                    Text('Download'),
                  ],
                ),
              ),
            PopupMenuItem<String>(
              value: 'remove',
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'delete',
                    color: AppTheme.errorRed,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Text('Remove', style: TextStyle(color: AppTheme.errorRed)),
                ],
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: CustomIconWidget(
              iconName: 'more_vert',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('library_item_${item["id"]}'),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 6.w),
        color: AppTheme.primaryGreen,
        child: CustomIconWidget(
          iconName: 'play_arrow',
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          size: 8.w,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 6.w),
        color: AppTheme.errorRed,
        child: CustomIconWidget(
          iconName: 'delete',
          color: AppTheme.lightTheme.colorScheme.onError,
          size: 8.w,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onSwipeRight();
          return false; // Don't actually dismiss
        } else {
          onSwipeLeft();
          return false; // Don't actually dismiss
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(2.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Row(
                children: [
                  _buildLeadingWidget(),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getTitle(),
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          _getSubtitle(),
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _buildTrailingWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
