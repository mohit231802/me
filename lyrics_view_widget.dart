import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LyricsViewWidget extends StatefulWidget {
  final List<Map<String, dynamic>> lyrics;
  final int currentTime;
  final VoidCallback onClose;

  const LyricsViewWidget({
    super.key,
    required this.lyrics,
    required this.currentTime,
    required this.onClose,
  });

  @override
  State<LyricsViewWidget> createState() => _LyricsViewWidgetState();
}

class _LyricsViewWidgetState extends State<LyricsViewWidget> {
  late ScrollController _scrollController;
  int _currentLyricIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _updateCurrentLyric();
  }

  @override
  void didUpdateWidget(LyricsViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentTime != oldWidget.currentTime) {
      _updateCurrentLyric();
    }
  }

  void _updateCurrentLyric() {
    for (int i = 0; i < widget.lyrics.length; i++) {
      final lyricTime = widget.lyrics[i]["time"] as int;
      if (widget.currentTime >= lyricTime) {
        _currentLyricIndex = i;
      } else {
        break;
      }
    }

    // Auto-scroll to current lyric
    if (_scrollController.hasClients && _currentLyricIndex > 0) {
      _scrollController.animateTo(
        _currentLyricIndex * 80.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.pureBlack.withValues(alpha: 0.9),
            AppTheme.deepCharcoal.withValues(alpha: 0.95),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Lyrics content
            Expanded(
              child: _buildLyricsContent(),
            ),
          ],
        ),
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
            'Lyrics',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.darkTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: widget.onClose,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.darkTheme.colorScheme.surface
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.darkTheme.colorScheme.onSurface,
                size: 6.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLyricsContent() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      itemCount: widget.lyrics.length,
      itemBuilder: (context, index) {
        final lyric = widget.lyrics[index];
        final isCurrentLyric = index == _currentLyricIndex;
        final isPastLyric = index < _currentLyricIndex;

        return Container(
          margin: EdgeInsets.only(bottom: 3.h),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: isCurrentLyric
                      ? AppTheme.primaryGreen
                      : isPastLyric
                          ? AppTheme.darkTheme.colorScheme.onSurfaceVariant
                          : AppTheme.darkTheme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                  fontWeight:
                      isCurrentLyric ? FontWeight.w600 : FontWeight.w400,
                  fontSize: isCurrentLyric ? 20.sp : 18.sp,
                ) ??
                const TextStyle(),
            child: Text(
              lyric["text"] as String,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
