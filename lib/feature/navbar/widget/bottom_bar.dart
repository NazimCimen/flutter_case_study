part of '../view/navbar_view.dart';

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.cXxLargeValue,
      color: AppColors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocSelector<NavBarCubit, MainLayoutState, bool>(
            selector: (state) => state is MainLayoutLoaded && state.currentIndex == 0,
            builder: (context, isSelected) => _NavButton(
              icon: ImageEnums.ic_home.toPathPng,
              label: 'Anasayfa',
              isSelected: isSelected,
              onTap: () {
                context.read<NavBarCubit>().setTabIndex(0);
                HapticFeedback.mediumImpact();
              },
            ),
          ),
          BlocSelector<NavBarCubit, MainLayoutState, bool>(
            selector: (state) => state is MainLayoutLoaded && state.currentIndex == 1,
            builder: (context, isSelected) => _NavButton(
              icon: ImageEnums.ic_profile.toPathPng,
              label: 'Profil',
              isSelected: isSelected,
              onTap: () {
                context.read<NavBarCubit>().setTabIndex(1);
                HapticFeedback.mediumImpact();
              },
            ),
          ),
        ],
      ),
    );
  }
}

