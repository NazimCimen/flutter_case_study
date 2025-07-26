import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/core/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Widget for displaying a favorite movie card with poster and info
class FavoriteMovieCard extends StatelessWidget {
  final String title;
  final String studio;
  final String? posterUrl;

  const FavoriteMovieCard({
    required this.title,
    required this.studio,
    this.posterUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Movie Poster
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: context.cBorderRadiusAllMedium,
              color: Colors.grey[800],
            ),
            child: ClipRRect(
              borderRadius: context.cBorderRadiusAllMedium,
              child: posterUrl != null
                  ? CachedNetworkImage(
                      imageUrl: StringUtils.fixImageUrl(posterUrl!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.movie,
                            color: Colors.white54,
                            size: 40,
                          ),
                        ),
                      ),
                      memCacheWidth: 200,
                      memCacheHeight: 300,
                    )
                  : Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(
                          Icons.movie,
                          color: Colors.white54,
                          size: 40,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        // Movie Info
        Padding(
          padding: EdgeInsets.all(context.cLowValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Movie Title
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Studio Name
              Text(
                studio,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
