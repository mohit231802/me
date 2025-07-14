import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CreatePlaylistCardWidget extends StatelessWidget {
  const CreatePlaylistCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showCreatePlaylistDialog(context);
          },
          borderRadius: BorderRadius.circular(3.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'add',
                      color: AppTheme.primaryGreen,
                      size: 8.w,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create New Playlist',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'Organize your favorite songs',
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                CustomIconWidget(
                  iconName: 'chevron_right',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Create Playlist',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Playlist Name',
                  hintText: 'Enter playlist name',
                ),
                autofocus: true,
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Add a description',
                ),
                maxLines: 3,
              ),
            ],
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
                if (nameController.text.trim().isNotEmpty) {
                  // Handle playlist creation
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Playlist "${nameController.text}" created successfully'),
                      backgroundColor: AppTheme.primaryGreen,
                    ),
                  );
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
