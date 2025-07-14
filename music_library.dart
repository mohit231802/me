import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/create_playlist_card_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/library_item_widget.dart';
import './widgets/storage_indicator_widget.dart';

class MusicLibrary extends StatefulWidget {
  const MusicLibrary({super.key});

  @override
  State<MusicLibrary> createState() => _MusicLibraryState();
}

class _MusicLibraryState extends State<MusicLibrary>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedBottomNavIndex = 3; // Library tab active
  bool _isMultiSelectMode = false;
  Set<int> _selectedItems = {};
  String _searchQuery = '';
  String _sortOption = 'Recently Added';
  bool _isRefreshing = false;

  final List<String> _tabLabels = [
    'Recently Added',
    'Artists',
    'Albums',
    'Playlists',
    'Downloaded'
  ];

  final List<String> _sortOptions = [
    'Recently Added',
    'Alphabetical',
    'Date Added',
    'Most Played'
  ];

  // Mock data for library items
  final List<Map<String, dynamic>> _recentlyAddedItems = [
    {
      "id": 1,
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "album": "After Hours",
      "duration": "3:20",
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
      "isDownloaded": true,
      "dateAdded": DateTime.now().subtract(Duration(hours: 2)),
      "playCount": 45,
    },
    {
      "id": 2,
      "title": "Watermelon Sugar",
      "artist": "Harry Styles",
      "album": "Fine Line",
      "duration": "2:54",
      "imageUrl":
          "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop",
      "isDownloaded": false,
      "dateAdded": DateTime.now().subtract(Duration(days: 1)),
      "playCount": 32,
    },
    {
      "id": 3,
      "title": "Good 4 U",
      "artist": "Olivia Rodrigo",
      "album": "SOUR",
      "duration": "2:58",
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
      "isDownloaded": true,
      "dateAdded": DateTime.now().subtract(Duration(days: 3)),
      "playCount": 28,
    },
  ];

  final List<Map<String, dynamic>> _artistsData = [
    {
      "id": 1,
      "name": "The Weeknd",
      "songCount": 15,
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
    },
    {
      "id": 2,
      "name": "Harry Styles",
      "songCount": 8,
      "imageUrl":
          "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop",
    },
    {
      "id": 3,
      "name": "Olivia Rodrigo",
      "songCount": 12,
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
    },
  ];

  final List<Map<String, dynamic>> _albumsData = [
    {
      "id": 1,
      "title": "After Hours",
      "artist": "The Weeknd",
      "year": "2020",
      "songCount": 14,
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
    },
    {
      "id": 2,
      "title": "Fine Line",
      "artist": "Harry Styles",
      "year": "2019",
      "songCount": 12,
      "imageUrl":
          "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop",
    },
  ];

  final List<Map<String, dynamic>> _playlistsData = [
    {
      "id": 1,
      "title": "My Favorites",
      "songCount": 25,
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
      "isOwned": true,
    },
    {
      "id": 2,
      "title": "Workout Mix",
      "songCount": 18,
      "imageUrl":
          "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop",
      "isOwned": true,
    },
  ];

  final List<Map<String, dynamic>> _downloadedItems = [
    {
      "id": 1,
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "album": "After Hours",
      "duration": "3:20",
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
      "fileSize": "4.2 MB",
    },
    {
      "id": 3,
      "title": "Good 4 U",
      "artist": "Olivia Rodrigo",
      "album": "SOUR",
      "duration": "2:58",
      "imageUrl":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
      "fileSize": "3.8 MB",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate network call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _toggleMultiSelect() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedItems.clear();
      }
    });
  }

  void _toggleItemSelection(int itemId) {
    setState(() {
      if (_selectedItems.contains(itemId)) {
        _selectedItems.remove(itemId);
      } else {
        _selectedItems.add(itemId);
      }
    });
  }

  void _handleItemTap(Map<String, dynamic> item) {
    if (_isMultiSelectMode) {
      _toggleItemSelection(item["id"] as int);
    } else {
      Navigator.pushNamed(context, '/now-playing');
    }
  }

  void _handleItemLongPress(Map<String, dynamic> item) {
    if (!_isMultiSelectMode) {
      _toggleMultiSelect();
      _toggleItemSelection(item["id"] as int);
    }
  }

  List<dynamic> _getFilteredData() {
    List<dynamic> data = [];

    switch (_tabController.index) {
      case 0: // Recently Added
        data = _recentlyAddedItems;
        break;
      case 1: // Artists
        data = _artistsData;
        break;
      case 2: // Albums
        data = _albumsData;
        break;
      case 3: // Playlists
        data = _playlistsData;
        break;
      case 4: // Downloaded
        data = _downloadedItems;
        break;
    }

    if (_searchQuery.isNotEmpty) {
      data = data.where((item) {
        final title =
            (item["title"] ?? item["name"] ?? "").toString().toLowerCase();
        final artist = (item["artist"] ?? "").toString().toLowerCase();
        return title.contains(_searchQuery.toLowerCase()) ||
            artist.contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Sort data based on selected option
    switch (_sortOption) {
      case 'Alphabetical':
        data.sort((a, b) {
          final aTitle = (a["title"] ?? a["name"] ?? "").toString();
          final bTitle = (b["title"] ?? b["name"] ?? "").toString();
          return aTitle.compareTo(bTitle);
        });
        break;
      case 'Date Added':
        if (_tabController.index == 0) {
          data.sort((a, b) => (b["dateAdded"] as DateTime)
              .compareTo(a["dateAdded"] as DateTime));
        }
        break;
      case 'Most Played':
        if (_tabController.index == 0) {
          data.sort((a, b) =>
              (b["playCount"] as int).compareTo(a["playCount"] as int));
        }
        break;
    }

    return data;
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search in library',
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: CustomIconWidget(
                    iconName: 'clear',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 5.w,
                  ),
                )
              : PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      _sortOption = value;
                    });
                  },
                  itemBuilder: (context) => _sortOptions.map((option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: _sortOption == option ? 'check' : 'sort',
                            color: _sortOption == option
                                ? AppTheme.primaryGreen
                                : AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                            size: 5.w,
                          ),
                          SizedBox(width: 3.w),
                          Text(option),
                        ],
                      ),
                    );
                  }).toList(),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'sort',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 5.w,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        onTap: (index) {
          setState(() {
            _isMultiSelectMode = false;
            _selectedItems.clear();
          });
        },
        tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
      ),
    );
  }

  Widget _buildMultiSelectToolbar() {
    return _isMultiSelectMode
        ? Container(
            height: 8.h,
            color: AppTheme.lightTheme.colorScheme.primaryContainer,
            child: Row(
              children: [
                SizedBox(width: 4.w),
                Text(
                  '${_selectedItems.length} selected',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // Handle play selected
                  },
                  icon: CustomIconWidget(
                    iconName: 'play_arrow',
                    color: AppTheme.primaryGreen,
                    size: 6.w,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle add to playlist
                  },
                  icon: CustomIconWidget(
                    iconName: 'playlist_add',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 6.w,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle delete
                  },
                  icon: CustomIconWidget(
                    iconName: 'delete',
                    color: AppTheme.errorRed,
                    size: 6.w,
                  ),
                ),
                IconButton(
                  onPressed: _toggleMultiSelect,
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 6.w,
                  ),
                ),
                SizedBox(width: 2.w),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  Widget _buildContent() {
    final data = _getFilteredData();

    if (data.isEmpty) {
      return EmptyStateWidget(
        tabIndex: _tabController.index,
        searchQuery: _searchQuery,
      );
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Column(
        children: [
          if (_tabController.index == 3) // Playlists
            CreatePlaylistCardWidget(),
          if (_tabController.index == 4) // Downloaded
            StorageIndicatorWidget(
              totalSize: "24.8 MB",
              itemCount: _downloadedItems.length,
            ),
          Expanded(
            child: _tabController.index == 2 // Albums
                ? _buildAlbumsGrid(data)
                : _buildListView(data),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<dynamic> data) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index] as Map<String, dynamic>;
        return LibraryItemWidget(
          item: item,
          tabIndex: _tabController.index,
          isSelected: _selectedItems.contains(item["id"]),
          isMultiSelectMode: _isMultiSelectMode,
          onTap: () => _handleItemTap(item),
          onLongPress: () => _handleItemLongPress(item),
          onSwipeRight: () {
            // Handle quick play
            Navigator.pushNamed(context, '/now-playing');
          },
          onSwipeLeft: () {
            // Handle remove/delete
          },
        );
      },
    );
  }

  Widget _buildAlbumsGrid(List<dynamic> data) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 2.h,
        childAspectRatio: 0.8,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final album = data[index] as Map<String, dynamic>;
        return GestureDetector(
          onTap: () => _handleItemTap(album),
          onLongPress: () => _handleItemLongPress(album),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
              color: AppTheme.lightTheme.colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3.w),
                          child: CustomImageWidget(
                            imageUrl: album["imageUrl"] as String,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (_isMultiSelectMode)
                          Positioned(
                            top: 2.w,
                            right: 2.w,
                            child: Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _selectedItems.contains(album["id"])
                                    ? AppTheme.primaryGreen
                                    : AppTheme.lightTheme.colorScheme.surface
                                        .withValues(alpha: 0.8),
                              ),
                              child: _selectedItems.contains(album["id"])
                                  ? CustomIconWidget(
                                      iconName: 'check',
                                      color: AppTheme
                                          .lightTheme.colorScheme.onPrimary,
                                      size: 4.w,
                                    )
                                  : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album["title"] as String,
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '${album["artist"]} • ${album["year"]}',
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedBottomNavIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _selectedBottomNavIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home-feed');
            break;
          case 1:
            Navigator.pushNamed(context, '/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/now-playing');
            break;
          case 3:
            // Current screen - Library
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'home',
            color: _selectedBottomNavIndex == 0
                ? AppTheme.primaryGreen
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'search',
            color: _selectedBottomNavIndex == 1
                ? AppTheme.primaryGreen
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'music_note',
            color: _selectedBottomNavIndex == 2
                ? AppTheme.primaryGreen
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          label: 'Now Playing',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'library_music',
            color: _selectedBottomNavIndex == 3
                ? AppTheme.primaryGreen
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          label: 'Library',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Library'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _toggleMultiSelect,
            icon: CustomIconWidget(
              iconName: _isMultiSelectMode ? 'close' : 'more_vert',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabBar(),
          _buildMultiSelectToolbar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  List.generate(_tabLabels.length, (index) => _buildContent()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
