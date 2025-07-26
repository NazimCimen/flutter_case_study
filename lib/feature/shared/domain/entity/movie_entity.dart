import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class MovieEntity extends Equatable {
  final String? id;
  @JsonKey(name: 'Title')
  final String? title;
  @JsonKey(name: 'Plot')
  final String? description;
  @JsonKey(name: 'Poster')
  final String? posterUrl;
  final bool isFavorite;
  const MovieEntity({
    this.id,
    this.title,
    this.description,
    this.posterUrl,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, title, description, posterUrl, isFavorite];

  MovieEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? posterUrl,
    bool? isFavorite,
  }) => MovieEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    posterUrl: posterUrl ?? this.posterUrl,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}
