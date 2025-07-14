import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/album_artwork_widget.dart';
import './widgets/lyrics_view_widget.dart';
import './widgets/playback_controls_widget.dart';
import './widgets/progress_bar_widget.dart';
import './widgets/queue_bottom_sheet_widget.dart';
import './widgets/secondary_controls_widget.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> with TickerProviderStateMixin {
  late AnimationController _parallaxController;
  late AnimationController _slideController;
  late TabController _tabController;

  bool _isPlaying = true;
  bool _isShuffleOn = false;
  bool _isRepeatOn = false;
  bool _showLyrics = false;
  bool _showQueue = false;
  double _currentPosition = 0.45; // 45% of song played
  double _volume = 0.7;

  // Mock current song data
  final Map<String, dynamic> _currentSong = {
    "id": 1,
    "title": "Blinding Lights",
    "artist": "The Weeknd",
    "album": "After Hours",
    "duration": "3:20",
    "currentTime": "1:30",
    "albumArt":
        "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=500&h=500&fit=crop",
    "isLiked": true,
    "isDownloaded": true,
    "lyrics": [
      {"time": 0, "text": "Yeah, I've been tryna call"},
      {"time": 5, "text": "I've been on my own for long enough"},
      {"time": 10, "text": "Maybe you can show me how to love, maybe"},
      {
        "time": 15,
        "text": "I feel like I'm just missing something when you're gone"
      },
      {"time": 20, "text": "And I never have a day without you"},
      {
        "time": 25,
        "text": "I feel like I'm just missing something when you're gone"
      },
      {
        "time": 30,
        "text": "I feel like I'm just missing something when you're gone"
      },
      {"time": 35, "text": "And I never have a day without you"},
    ]
  };

  final List<Map<String, dynamic>> _queue = [
    {
      "id": 1,
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "albumArt":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=100&h=100&fit=crop",
      "duration": "3:20",
      "isPlaying": true,
    },
    {
      "id": 2,
      "title": "Save Your Tears",
      "artist": "The Weeknd",
      "albumArt":
          "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=100&h=100&fit=crop",
      "duration": "3:35",
      "isPlaying": false,
    },
    {
      "id": 3,
      "title": "Levitating",
      "artist": "Dua Lipa",
      "albumArt":
          "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=100&h=100&fit=crop",
      "duration": "3:23",
      "isPlaying": false,
    },
    {
      "id": 4,
      "title": "Good 4 U",
      "artist": "Olivia Rodrigo",
      "albumArt":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=100&h=100&fit=crop",
      "duration": "2:58",
      "isPlaying": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _parallaxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _parallaxController.dispose();
    _slideController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    HapticFeedback.lightImpact();
  }

  void _toggleShuffle() {
    setState(() {
      _isShuffleOn = !_isShuffleOn;
    });
    HapticFeedback.lightImpact();
  }

  void _toggleRepeat() {
    setState(() {
      _isRepeatOn = !_isRepeatOn;
    });
    HapticFeedback.lightImpact();
  }

  void _showQueueBottomSheet() {
    setState(() {
      _showQueue = true;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QueueBottomSheetWidget(
        queue: _queue,
        onReorder: (oldIndex, newIndex) {
          // Handle queue reordering
        },
        onSongTap: (songId) {
          Navigator.pop(context);
          // Handle song selection
        },
      ),
    ).then((_) {
      setState(() {
        _showQueue = false;
      });
    });
  }

  void _showLyricsView() {
    setState(() {
      _showLyrics = true;
    });
    _slideController.forward();
  }

  void _hideLyricsView() {
    setState(() {
      _showLyrics = false;
    });
    _slideController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // Header with dismiss button
                _buildHeader(),

                // Album artwork section
                Expanded(
                  flex: 3,
                  child: AlbumArtworkWidget(
                    imageUrl: _currentSong["albumArt"] as String,
                    isPlaying: _isPlaying,
                    parallaxController: _parallaxController,
                  ),
                ),

                // Song info and controls section
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),

                        // Song title and artist
                        _buildSongInfo(),

                        SizedBox(height: 3.h),

                        // Progress bar
                        ProgressBarWidget(
                          currentPosition: _currentPosition,
                          currentTime: _currentSong["currentTime"] as String,
                          totalTime: _currentSong["duration"] as String,
                          onSeek: (value) {
                            setState(() {
                              _currentPosition = value;
                            });
                          },
                        ),

                        SizedBox(height: 3.h),

                        // Primary playback controls
                        PlaybackControlsWidget(
                          isPlaying: _isPlaying,
                          onPlayPause: _togglePlayPause,
                          onPrevious: () {
                            HapticFeedback.lightImpact();
                            // Handle previous track
                          },
                          onNext: () {
                            HapticFeedback.lightImpact();
                            // Handle next track
                          },
                        ),

                        SizedBox(height: 2.h),

                        // Secondary controls
                        SecondaryControlsWidget(
                          isShuffleOn: _isShuffleOn,
                          isRepeatOn: _isRepeatOn,
                          isLiked: _currentSong["isLiked"] as bool,
                          isDownloaded: _currentSong["isDownloaded"] as bool,
                          onShuffle: _toggleShuffle,
                          onRepeat: _toggleRepeat,
                          onLike: () {
                            setState(() {
                              _currentSong["isLiked"] =
                                  !(_currentSong["isLiked"] as bool);
                            });
                            HapticFeedback.lightImpact();
                          },
                          onQueue: _showQueueBottomSheet,
                          onShare: () {
                            // Handle share
                            HapticFeedback.lightImpact();
                          },
                          onLyrics: _showLyricsView,
                        ),

                        SizedBox(height: 1.h),

                        // Volume slider
                        _buildVolumeSlider(),

                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Lyrics overlay
            if (_showLyrics)
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _slideController,
                  curve: Curves.easeInOut,
                )),
                child: LyricsViewWidget(
                  lyrics: (_currentSong["lyrics"] as List)
                      .cast<Map<String, dynamic>>(),
                  currentTime: 15, // Mock current time in seconds
                  onClose: _hideLyricsView,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.darkTheme.colorScheme.surface
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                color: AppTheme.darkTheme.colorScheme.onSurface,
                size: 6.w,
              ),
            ),
          ),
          Text(
            'Now Playing',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.darkTheme.colorScheme.onSurface,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle more options
            },
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.darkTheme.colorScheme.surface
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'more_vert',
                color: AppTheme.darkTheme.colorScheme.onSurface,
                size: 6.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongInfo() {
    return Column(
      children: [
        Text(
          _currentSong["title"] as String,
          style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
            color: AppTheme.darkTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 0.5.h),
        Text(
          _currentSong["artist"] as String,
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildVolumeSlider() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'volume_down',
          color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
          size: 5.w,
        ),
        Expanded(
          child: Slider(
            value: _volume,
            onChanged: (value) {
              setState(() {
                _volume = value;
              });
            },
            activeColor: AppTheme.primaryGreen,
            inactiveColor: AppTheme.neutralGray.withValues(alpha: 0.3),
            thumbColor: AppTheme.primaryGreen,
          ),
        ),
        CustomIconWidget(
          iconName: 'volume_up',
          color: AppTheme.darkTheme.colorScheme.onSurfaceVariant,
          size: 5.w,
        ),
      ],
    );
  }
}
