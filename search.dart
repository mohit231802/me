import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/recent_search_item_widget.dart';
import './widgets/search_filter_chip_widget.dart';
import './widgets/search_result_item_widget.dart';
import './widgets/top_result_card_widget.dart';
import './widgets/trending_search_card_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _selectedFilter = 'Songs';
  bool _isSearching = false;
  String _searchQuery = '';
  late TabController _tabController;

  final List<String> _filters = ['Songs', 'Artists', 'Albums', 'Playlists'];

  final List<Map<String, dynamic>> _recentSearches = [
    {
      "id": 1,
      "query": "Billie Eilish",
      "type": "Artist",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      "id": 2,
      "query": "Bad Guy",
      "type": "Song",
      "timestamp": DateTime.now().subtract(Duration(hours: 5)),
    },
    {
      "id": 3,
      "query": "Pop Hits 2024",
      "type": "Playlist",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "id": 4,
      "query": "The Weeknd",
      "type": "Artist",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
    },
  ];

  final List<Map<String, dynamic>> _trendingSearches = [
    {
      "id": 1,
      "title": "Taylor Swift",
      "subtitle": "Trending Artist",
      "image":
          "https://images.pexels.com/photos/1587927/pexels-photo-1587927.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "Artist"
    },
    {
      "id": 2,
      "title": "Anti-Hero",
      "subtitle": "Trending Song",
      "image":
          "https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "Song"
    },
    {
      "id": 3,
      "title": "Today's Top Hits",
      "subtitle": "Popular Playlist",
      "image":
          "https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "Playlist"
    },
  ];

  final List<Map<String, dynamic>> _searchResults = [
    {
      "id": 1,
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "album": "After Hours",
      "duration": "3:20",
      "image":
          "https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "Song",
      "isTopResult": true,
    },
    {
      "id": 2,
      "title": "Save Your Tears",
      "artist": "The Weeknd",
      "album": "After Hours",
      "duration": "3:35",
      "image":
          "https://images.pexels.com/photos/1587927/pexels-photo-1587927.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "Song",
      "isTopResult": false,
    },
    {
      "id": 3,
      "title": "The Weeknd",
      "subtitle": "Artist • 85.2M monthly listeners",
      "image":
          "https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "Artist",
      "isTopResult": false,
    },
    {
      "id": 4,
      "title": "After Hours",
      "artist": "The Weeknd",
      "year": "2020",
      "image":
          "https://images.pixabay.com/photo/2017/08/06/12/06/people-2591874_1280.jpg",
      "type": "Album",
      "isTopResult": false,
    },
  ];

  final List<Map<String, dynamic>> _popularGenres = [
    {
      "id": 1,
      "name": "Pop",
      "color": Color(0xFFFF6B6B),
      "image":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop"
    },
    {
      "id": 2,
      "name": "Hip-Hop",
      "color": Color(0xFF4ECDC4),
      "image":
          "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop"
    },
    {
      "id": 3,
      "name": "Rock",
      "color": Color(0xFFFFE66D),
      "image":
          "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400&h=400&fit=crop"
    },
    {
      "id": 4,
      "name": "Electronic",
      "color": Color(0xFFA8E6CF),
      "image":
          "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.index = 1; // Set Search tab as active
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _onRecentSearchTap(String query) {
    _searchController.text = query;
    _onSearchChanged(query);
  }

  void _onRecentSearchDelete(int id) {
    setState(() {
      _recentSearches.removeWhere((search) => (search["id"] as int) == id);
    });
  }

  void _onVoiceSearch() {
    // Voice search implementation would go here
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Voice search activated'),
        duration: Duration(seconds: 2)));
  }

  void _onTabTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/splash-screen');
        break;
      case 1:
        // Current screen - Search
        break;
      case 2:
        Navigator.pushNamed(context, '/home-feed');
        break;
      case 3:
        Navigator.pushNamed(context, '/music-library');
        break;
      case 4:
        Navigator.pushNamed(context, '/now-playing');
        break;
      case 5:
        Navigator.pushNamed(context, '/login-screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        appBar: AppBar(
            backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
            elevation: 0,
            title: Container(
                height: 6.h,
                decoration: BoxDecoration(
                    color: AppTheme.trueDarkSurface,
                    borderRadius: BorderRadius.circular(12.0)),
                child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: _onSearchChanged,
                    style: AppTheme.darkTheme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                        hintText: 'What do you want to listen to?',
                        hintStyle: AppTheme.darkTheme.textTheme.bodyMedium
                            ?.copyWith(color: AppTheme.textSecondary),
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(2.w),
                            child: CustomIconWidget(
                                iconName: 'search',
                                color: AppTheme.textSecondary,
                                size: 5.w)),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  _onSearchChanged('');
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: CustomIconWidget(
                                        iconName: 'clear',
                                        color: AppTheme.textSecondary,
                                        size: 5.w)))
                            : GestureDetector(
                                onTap: _onVoiceSearch,
                                child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: CustomIconWidget(
                                        iconName: 'mic',
                                        color: AppTheme.textSecondary,
                                        size: 5.w))),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.5.h))))),
        body: Column(children: [
          // Filter Chips
          Container(
              height: 6.h,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (context, index) => SizedBox(width: 2.w),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    return SearchFilterChipWidget(
                        label: filter,
                        isSelected: _selectedFilter == filter,
                        onTap: () => _onFilterSelected(filter));
                  })),
          SizedBox(height: 2.h),
          // Main Content
          Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildDefaultContent()),
        ]),
        bottomNavigationBar: Container(
            decoration:
                BoxDecoration(color: AppTheme.trueDarkSurface, boxShadow: [
              BoxShadow(
                  color: AppTheme.shadowDark,
                  blurRadius: 8,
                  offset: Offset(0, -2)),
            ]),
            child: TabBar(
                controller: _tabController,
                onTap: _onTabTap,
                indicator: BoxDecoration(),
                labelColor: AppTheme.primaryGreen,
                unselectedLabelColor: AppTheme.textSecondary,
                labelStyle: AppTheme.darkTheme.textTheme.labelSmall,
                unselectedLabelStyle: AppTheme.darkTheme.textTheme.labelSmall,
                tabs: [
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'home',
                          color: _tabController.index == 0
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                          size: 6.w),
                      text: 'Home'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'search',
                          color: _tabController.index == 1
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                          size: 6.w),
                      text: 'Search'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'library_music',
                          color: _tabController.index == 2
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                          size: 6.w),
                      text: 'Library'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'radio',
                          color: _tabController.index == 3
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                          size: 6.w),
                      text: 'Radio'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'play_circle_filled',
                          color: _tabController.index == 4
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                          size: 6.w),
                      text: 'Playing'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'person',
                          color: _tabController.index == 5
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                          size: 6.w),
                      text: 'Profile'),
                ])));
  }

  Widget _buildDefaultContent() {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            Text('Recent searches',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
            SizedBox(height: 2.h),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _recentSearches.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  final search = _recentSearches[index];
                  return RecentSearchItemWidget(
                      query: search["query"] as String,
                      type: search["type"] as String,
                      onTap: () =>
                          _onRecentSearchTap(search["query"] as String),
                      onDelete: () =>
                          _onRecentSearchDelete(search["id"] as int));
                }),
            SizedBox(height: 4.h),
          ],
          // Trending Searches
          Text('Trending now',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
          SizedBox(height: 2.h),
          SizedBox(
              height: 20.h,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _trendingSearches.length,
                  separatorBuilder: (context, index) => SizedBox(width: 3.w),
                  itemBuilder: (context, index) {
                    final trending = _trendingSearches[index];
                    return TrendingSearchCardWidget(
                        title: trending["title"] as String,
                        subtitle: trending["subtitle"] as String,
                        imageUrl: trending["image"] as String,
                        onTap: () =>
                            _onRecentSearchTap(trending["title"] as String));
                  })),
          SizedBox(height: 4.h),
          // Popular Genres
          Text('Browse all',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
          SizedBox(height: 2.h),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: 2.0),
              itemCount: _popularGenres.length,
              itemBuilder: (context, index) {
                final genre = _popularGenres[index];
                return GestureDetector(
                    onTap: () => _onRecentSearchTap(genre["name"] as String),
                    child: Container(
                        decoration: BoxDecoration(
                            color: genre["color"] as Color,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Stack(children: [
                          Positioned(
                              top: 3.w,
                              left: 3.w,
                              child: Text(genre["name"] as String,
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                          color: AppTheme.textPrimary,
                                          fontWeight: FontWeight.w600))),
                          Positioned(
                              bottom: -2.h,
                              right: -2.w,
                              child: Transform.rotate(
                                  angle: 0.3,
                                  child: Container(
                                      width: 15.w,
                                      height: 15.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CustomImageWidget(
                                              imageUrl:
                                                  genre["image"] as String,
                                              width: 15.w,
                                              height: 15.w,
                                              fit: BoxFit.cover))))),
                        ])));
              }),
          SizedBox(height: 4.h),
        ]));
  }

  Widget _buildSearchResults() {
    final filteredResults = _searchResults.where((result) {
      if (_selectedFilter == 'Songs') return result["type"] == 'Song';
      if (_selectedFilter == 'Artists') return result["type"] == 'Artist';
      if (_selectedFilter == 'Albums') return result["type"] == 'Album';
      if (_selectedFilter == 'Playlists') return result["type"] == 'Playlist';
      return true;
    }).toList();

    final topResult = _searchResults.firstWhere(
        (result) => result["isTopResult"] == true,
        orElse: () => _searchResults.first);

    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Top Result
          if (_selectedFilter == 'Songs' || _selectedFilter == 'All') ...[
            Text('Top result',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
            SizedBox(height: 2.h),
            TopResultCardWidget(
                title: topResult["title"] as String,
                artist: topResult["artist"] as String? ?? '',
                imageUrl: topResult["image"] as String,
                type: topResult["type"] as String,
                onTap: () {
                  Navigator.pushNamed(context, '/now-playing');
                }),
            SizedBox(height: 4.h),
          ],
          // Results List
          Text(_selectedFilter,
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
          SizedBox(height: 2.h),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredResults.length,
              separatorBuilder: (context, index) => SizedBox(height: 1.h),
              itemBuilder: (context, index) {
                final result = filteredResults[index];
                return SearchResultItemWidget(
                    title: result["title"] as String,
                    subtitle: result["artist"] as String? ??
                        result["subtitle"] as String? ??
                        result["year"]?.toString() ??
                        '',
                    imageUrl: result["image"] as String,
                    type: result["type"] as String,
                    duration: result["duration"] as String?,
                    onTap: () {
                      if (result["type"] == 'Song') {
                        Navigator.pushNamed(context, '/now-playing');
                      } else if (result["type"] == 'Artist') {
                        // Navigate to artist profile
                      } else if (result["type"] == 'Album') {
                        // Navigate to album view
                      }
                    },
                    onMoreTap: () {
                      // Show context menu
                    });
              }),
          SizedBox(height: 4.h),
        ]));
  }
}
