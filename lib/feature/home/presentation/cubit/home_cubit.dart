import 'package:case_study/feature/home/domain/usecase/get_movie_list_usecase.dart';
import 'package:case_study/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeCubit extends Cubit<HomeState> {
  final GetMovieListUseCase getMovieListUseCase;

  HomeCubit({required this.getMovieListUseCase}) : super(HomeInitial());

  /// Load movies when view is initialized
  Future<void> loadMovies({int page = 4}) async {
    emit(HomeLoading());
    final result = await getMovieListUseCase.call(page: page);
    result.fold(
      (failure) => emit(HomeError(failure.errorMessage)),
      (movies) => emit(HomeSuccess(movies ?? [])),
    );
  }

  /// Refresh movies
  Future<void> refreshMovies() async {
    await loadMovies(page: 1);
  }

  /// Fetch a single page of movies for infinite scroll
  Future<void> fetchMoviesPage(int page) async {
    final result = await getMovieListUseCase.call(page: page);
    return result.fold(
      (failure) => emit(HomeError(failure.errorMessage)),
      (movies) => emit(HomeSuccess(movies ?? [])),
    );
  }
}
