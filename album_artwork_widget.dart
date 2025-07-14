import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AlbumArtworkWidget extends StatefulWidget {
  final String imageUrl;
  final bool isPlaying;
  final AnimationController parallaxController;

  const AlbumArtworkWidget({
    super.key,
    required this.imageUrl,
    required this.isPlaying,
    required this.parallaxController,
  });

  @override
  State<AlbumArtworkWidget> createState() => _AlbumArtworkWidgetState();
}

class _AlbumArtworkWidgetState extends State<AlbumArtworkWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_rotationController);

    if (widget.isPlaying) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(AlbumArtworkWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _rotationController.repeat();
      } else {
        _rotationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Center(
        child: Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowDark,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Album artwork
                AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value * 2 * 3.14159,
                      child: CustomImageWidget(
                        imageUrl: widget.imageUrl,
                        width: 70.w,
                        height: 70.w,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),

                // Gradient overlay for better text readability
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppTheme.pureBlack.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),

                // Vinyl record effect when playing
                if (widget.isPlaying)
                  Center(
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: AppTheme.pureBlack.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: const BoxDecoration(
                            color: AppTheme.textPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
