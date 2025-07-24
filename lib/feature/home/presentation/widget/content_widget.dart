part of '../view/home_view.dart';

class _ContentWidget extends StatelessWidget {
  final MovieEntity movie;

  const _ContentWidget({required this.movie});

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
              child: const Icon(Icons.favorite, size: 24),
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
                                text:
                                    movie.description ??
                                    'Community every territories dogpile so. Last they investigation model',
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
                                text: 'Daha Fazlası',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                              ),
                            ],
                          ),
                          maxLines: 2,
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
    return url != null
        ? Image.network(
            url!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.grey[300]),
          )
        : Image.asset(
            'assets/images/default_movie.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
  }
}
