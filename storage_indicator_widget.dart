import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StorageIndicatorWidget extends StatelessWidget {
  final String totalSize;
  final int itemCount;

  const StorageIndicatorWidget({
    super.key,
    required this.totalSize,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primaryContainer
            .withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'download_done',
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                size: 6.w,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Downloaded Music',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      totalSize,
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$itemCount song${itemCount != 1 ? 's' : ''} available offline',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showStorageManagementDialog(context);
                      },
                      child: Text(
                        'Manage',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showStorageManagementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Storage Management',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStorageItem(
                  'Downloaded Songs', totalSize, AppTheme.primaryGreen),
              SizedBox(height: 2.h),
              _buildStorageItem('Cache', '12.3 MB',
                  AppTheme.lightTheme.colorScheme.onSurfaceVariant),
              SizedBox(height: 2.h),
              _buildStorageItem('Offline Playlists', '8.7 MB',
                  AppTheme.lightTheme.colorScheme.onSurfaceVariant),
              SizedBox(height: 3.h),
              Text(
                'Total Storage Used: ${_calculateTotalStorage()}',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showClearCacheConfirmation(context);
              },
              child: Text(
                'Clear Cache',
                style: TextStyle(color: AppTheme.errorRed),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStorageItem(String label, String size, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        Text(
          size,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _calculateTotalStorage() {
    // Simple calculation for demo purposes
    return '45.8 MB';
  }

  void _showClearCacheConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Clear Cache',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          content: Text(
            'This will clear cached data but keep your downloaded music. Are you sure?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cache cleared successfully'),
                    backgroundColor: AppTheme.primaryGreen,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed,
              ),
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}
