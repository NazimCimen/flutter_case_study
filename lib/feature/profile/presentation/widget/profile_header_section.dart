import 'package:case_study/feature/profile/presentation/widget/profile_header.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_state.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget for displaying the profile header section with user information
class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileLoaded) {
          return ProfileHeader(user: state.user);
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
                  child: Text(StringConstants.retryButton),
                ),
              ],
            ),
          );
        }
        // For ProfileInitial state, show loading or empty state
        return const SizedBox.shrink();
      },
    );
  }
} 