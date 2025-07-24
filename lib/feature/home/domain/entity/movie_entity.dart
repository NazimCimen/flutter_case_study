import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? posterUrl;

  const MovieEntity({this.id, this.title, this.description, this.posterUrl});

  @override
  List<Object?> get props => [id, title, description, posterUrl];

  MovieEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? posterUrl,
  }) => MovieEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    posterUrl: posterUrl ?? this.posterUrl,
  );
}
