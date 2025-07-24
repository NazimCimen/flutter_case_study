import 'package:case_study/config/routes/app_routes.dart';
import 'package:case_study/config/routes/navigator_service.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/services/token_services.dart';
import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/di/di_container.dart';
import 'package:case_study/feature/profile/presentation/widget/custom_profile_appbar.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_state.dart';
import 'package:case_study/feature/auth/domain/entity/user_entity.dart';
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
      appBar: const CustomProfileAppBar(isOffer: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getIt<TokenService>().clearToken();
          NavigatorService.pushNamed(AppRoutes.loginView);
        },
        child: const Icon(Icons.logout),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.cMediumValue,
            vertical: context.cLargeValue,
          ),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (state is ProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${state.message}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<ProfileCubit>().loadProfile(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              
              if (state is ProfileLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeader(user: state.user),
                    SizedBox(height: context.cLargeValue),
                    Text(
                      'Beğendiğim Filmler',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                );
              }
              
              return const Center(child: Text('No user data'));
            },
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final UserEntity user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profil Fotoğrafı
        CircleAvatar(
          radius: 30,
          backgroundImage: user.photoUrl != null 
            ? NetworkImage(user.photoUrl!)
            : null,
          child: user.photoUrl == null 
            ? const Icon(Icons.person, size: 30)
            : null,
        ),
        SizedBox(width: context.cLowValue),
        // İsim ve ID
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? 'Unknown User',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ID: ${user.id ?? 'N/A'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        // Fotoğraf Ekle Butonu
        ElevatedButton(
          onPressed: () {
            NavigatorService.pushNamed(AppRoutes.profileDetailView);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: context.cLargeValue,
              vertical: context.cLowValue * 3 / 4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: context.cBorderRadiusAllMedium,
            ),
          ),
          child: Text(
            'Fotoğraf Ekle',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
