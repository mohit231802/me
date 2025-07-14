import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final int tabIndex;
  final String searchQuery;

  const EmptyStateWidget({
    super.key,
    required this.tabIndex,
    required this.searchQuery,
  });

  String _getEmptyTitle() {
    if (searchQuery.isNotEmpty) {
      return 'No results found';
    }

    switch (tabIndex) {
      case 0:
        return 'No music in your library';
      case 1:
        return 'No artists found';
      case 2:
        return 'No albums found';
      case 3:
        return 'No playlists created';
      case 4:
        return 'No downloaded music';
      default:
        return 'Nothing here yet';
    }
  }

  String _getEmptySubtitle() {
    if (searchQuery.isNotEmpty) {
      return 'Try searching with different keywords';
    }

    switch (tabIndex) {
      case 0:
        return 'Start building your library by adding songs, albums, and playlists';
      case 1:
        return 'Follow your favorite artists to see them here';
      case 2:
        return 'Save albums to access them quickly';
      case 3:
        return 'Create playlists to organize your music';
      case 4:
        return 'Download music for offline listening';
      default:
        return 'Start exploring to build your collection';
    }
  }

  String _getActionText() {
    if (searchQuery.isNotEmpty) {
      return 'Clear Search';
    }

    switch (tabIndex) {
      case 0:
        return 'Browse Music';
      case 1:
        return 'Discover Artists';
      case 2:
        return 'Find Albums';
      case 3:
        return 'Create Playlist';
      case 4:
        return 'Browse Music';
      default:
        return 'Get Started';
    }
  }

  String _getIconName() {
    if (searchQuery.isNotEmpty) {
      return 'search_off';
    }

    switch (tabIndex) {
      case 0:
        return 'library_music';
      case 1:
        return 'person';
      case 2:
        return 'album';
      case 3:
        return 'playlist_play';
      case 4:
        return 'download';
      default:
        return 'music_note';
    }
  }

  void _handleAction(BuildContext context) {
    if (searchQuery.isNotEmpty) {
      // Clear search - this would be handled by parent widget
      return;
    }

    switch (tabIndex) {
      case 0:
      case 1:
      case 2:
      case 4:
        Navigator.pushNamed(context, '/search');
        break;
      case 3:
        // Create playlist action would be handled by parent
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: _getIconName(),
                  color: AppTheme.primaryGreen,
                  size: 10.w,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _getEmptyTitle(),
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              _getEmptySubtitle(),
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () => _handleAction(context),
              child: Text(_getActionText()),
            ),
            if (tabIndex == 0 && searchQuery.isEmpty) ...[
              SizedBox(height: 3.h),
              Text(
                'Suggestions:',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              Wrap(
                spacing: 2.w,
                runSpacing: 1.h,
                children: [
                  _buildSuggestionChip('Top Charts'),
                  _buildSuggestionChip('New Releases'),
                  _buildSuggestionChip('Discover Weekly'),
                  _buildSuggestionChip('Your Mix'),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Text(
        label,
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.primaryGreen,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
