import 'package:case_study/feature/home/domain/entity/movie_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends MovieEntity {
  const MovieModel({super.id, super.title, super.description, super.posterUrl});

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  MovieEntity toEntity() => MovieEntity(
    id: id ?? '',
    title: title ?? '',
    description: description ?? '',
    posterUrl: posterUrl ?? '',
  );
}
