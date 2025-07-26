import 'package:flutter/material.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';
import 'package:case_study/config/localization/string_constants.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 80,
                height: 120,
                color: Colors.grey[300],
                child: movie.posterUrl != null && movie.posterUrl!.isNotEmpty
                    ? Image.network(
                        movie.posterUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.movie,
                            size: 40,
                            color: Colors.grey,
                          );
                        },
                      )
                    : const Icon(Icons.movie, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 16),

            // Movie details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? StringConstants.unknownTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.description ?? StringConstants.noDescriptionAvailable,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (movie.id != null)
                    Text(
                      '${StringConstants.movieIdLabel}: ${movie.id}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
