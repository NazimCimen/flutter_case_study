part of '../view/home_view.dart';

class _ContentWidget extends StatelessWidget {
  final MovieEntity movie;
  final void Function(MovieEntity) updateMovie;
  const _ContentWidget({required this.movie, required this.updateMovie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Poster Image
        Positioned.fill(child: _ImageWidget(url: movie.posterUrl)),

        // Gradient overlay for readability
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
        ),

        // like button
        Positioned(
          right: 14,
          bottom: 120,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                if (movie.id != null && movie.id!.isNotEmpty) {
                  final updatedMovie = movie.copyWith(
                    isFavorite: !movie.isFavorite,
                  );
                  updateMovie(updatedMovie);
                }
              },
              child: Container(
                height: 60,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.2),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  movie.isFavorite == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 24,
                  color: movie.isFavorite == true ? Colors.red : Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Bottom content
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: SafeArea(
              child: Row(
                children: [
                  Image.asset(
                    ImageEnums.movie_default_logo.toPathPng,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  // Movie info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                movie.title ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: (movie.description ?? '').length > 50 
                                    ? '${(movie.description ?? '').substring(0, 50)}...'
                                    : movie.description ?? '',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: AppColors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                    ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 4)),
                              TextSpan(
                                text: StringConstants.moreInfo,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: AppColors.white,
                                    ),
                              ),
                            ],
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final String? url;

  const _ImageWidget({required this.url});

  @override
  Widget build(BuildContext context) {
    return url != null && url!.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: StringUtils.fixImageUrl(url!),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => Container(
              color: AppColors.white.withValues(alpha: 0.1),
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.white.withValues(alpha: 0.1),
              child: const Center(
                child: Icon(Icons.error, color: Colors.grey, size: 50),
              ),
            ),
            memCacheWidth: 800,
            memCacheHeight: 1200,
          )
        : Container(
            color: AppColors.white.withValues(alpha: 0.1),
            child: const Center(
              child: Icon(Icons.movie, color: Colors.grey, size: 50),
            ),
          );
  }
}
