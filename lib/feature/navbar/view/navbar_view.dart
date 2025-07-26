import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:case_study/feature/home/presentation/view/home_view.dart';
import 'package:case_study/feature/profile/presentation/view/profile_view.dart';
import 'package:case_study/feature/navbar/viewmodel/navbar_view_model.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widget/bottom_bar.dart';
part '../widget/nav_button.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, MainLayoutState>(
      builder: (context, state) {
        final currentIndex = state is MainLayoutLoaded ? state.currentIndex : 0;
        return Scaffold(
          backgroundColor: AppColors.background,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: const SafeArea(child: _BottomBar()),
          body: currentIndex == 0
              ? HomeView(
                  key: ValueKey(
                    state is MainLayoutLoaded ? state.homeRebuildCount : 0,
                  ),
                )
              : const ProfileView(),
        );
      },
    );
  }
}
