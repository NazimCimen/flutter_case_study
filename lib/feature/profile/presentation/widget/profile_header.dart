import 'package:case_study/config/routes/app_routes.dart';
import 'package:case_study/config/routes/navigator_service.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileHeader extends StatelessWidget {
  final UserEntity user;

  const ProfileHeader({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile Avatar
        _buildProfileAvatar(user.photoUrl),

        SizedBox(width: context.cLowValue),
        // Name and ID
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? StringConstants.unknownUser,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${StringConstants.userIdLabel}: ${user.id ?? 'N/A'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: context.cLowValue),

        // Add Photo Button
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
            StringConstants.addPhotoButton,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar(String? photoUrl) {
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.white.withValues(alpha: 0.1),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: photoUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.white.withValues(alpha: 0.1),
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.white.withValues(alpha: 0.1),
              child: const Icon(Icons.person, size: 30, color: Colors.grey),
            ),
            memCacheWidth: 120,
            memCacheHeight: 120,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.person, size: 30, color: Colors.grey),
      );
    }
  }
}
