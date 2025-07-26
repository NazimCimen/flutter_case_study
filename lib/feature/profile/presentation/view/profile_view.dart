import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/feature/profile/presentation/widget/sliver_profile_appbar.dart';
import 'package:case_study/feature/profile/presentation/widget/profile_header_section.dart';
import 'package:case_study/feature/profile/presentation/widget/favorite_movies_sliver_section.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    // Load profile when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom Sliver App Bar
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.cMediumValue * 1.3,
            ),
            sliver: const SliverProfileAppBar(isOffer: true),
          ),

          // Content with horizontal padding
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.cMediumValue * 1.3,
              vertical: context.cXLargeValue,
            ),
            sliver: const SliverToBoxAdapter(child: ProfileHeaderSection()),
          ),

          // Favorite Movies Section with same padding
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.cMediumValue * 1.3,
            ),
            sliver: const FavoriteMoviesSliverSection(),
          ),
        ],
      ),
    );
  }
}
