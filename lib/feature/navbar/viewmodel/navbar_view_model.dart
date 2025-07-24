import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Cubit
class NavBarCubit extends Cubit<MainLayoutState> {
  NavBarCubit()
    : super(const MainLayoutLoaded(currentIndex: 0, homeRebuildCount: 0));

  void setTabIndex(int index) {
    final currentState = state as MainLayoutLoaded;

    // If tapping home while already on home, rebuild it
    var newHomeRebuildCount = currentState.homeRebuildCount;
    if (index == 0 && currentState.currentIndex == 0) {
      newHomeRebuildCount++;
    }

    emit(
      currentState.copyWith(
        currentIndex: index,
        homeRebuildCount: newHomeRebuildCount,
      ),
    );
  }

  void reset() {
    emit(const MainLayoutLoaded(currentIndex: 0, homeRebuildCount: 0));
  }
}

// State
abstract class MainLayoutState extends Equatable {
  const MainLayoutState();

  @override
  List<Object?> get props => [];
}

class MainLayoutInitial extends MainLayoutState {
  const MainLayoutInitial();
}

class MainLayoutLoaded extends MainLayoutState {
  final int currentIndex;
  final int homeRebuildCount;

  const MainLayoutLoaded({
    required this.currentIndex,
    required this.homeRebuildCount,
  });

  @override
  List<Object?> get props => [currentIndex, homeRebuildCount];

  MainLayoutLoaded copyWith({int? currentIndex, int? homeRebuildCount}) {
    return MainLayoutLoaded(
      currentIndex: currentIndex ?? this.currentIndex,
      homeRebuildCount: homeRebuildCount ?? this.homeRebuildCount,
    );
  }
}
