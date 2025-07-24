import 'package:equatable/equatable.dart';
import 'package:case_study/feature/home/domain/entity/movie_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  final List<MovieEntity> movies;

  const HomeSuccess(this.movies);

  @override
  List<Object?> get props => [movies];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
