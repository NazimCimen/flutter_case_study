import 'package:case_study/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/feature/profile/upload_profile_image_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';

/// Bottom sheet widget for changing profile image with camera or gallery options.
class UploadProfileImageSheet extends StatefulWidget {
  const UploadProfileImageSheet({super.key});

  @override
  State<UploadProfileImageSheet> createState() =>
      _UploadProfileImageSheetState();
}

class _UploadProfileImageSheetState extends State<UploadProfileImageSheet>
    with UploadProfileImageMixin {
  /// Builds the profile image change sheet with image picker options.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.cMediumValue),
      child: Padding(
        padding: EdgeInsets.only(bottom: context.cMediumValue),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.cLargeValue),
            ),
          ),
          padding: EdgeInsets.all(context.cLargeValue),
          child: Column(
            children: [
              Text(
                'Profil Fotoğrafını Değiştir',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (image == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ImageOptionButton(
                      icon: Icons.photo_library_outlined,
                      label: 'Galeri',
                      onTap: () async => pickImage(ImageSource.gallery),
                    ),
                    _ImageOptionButton(
                      icon: Icons.camera_alt_outlined,
                      label: 'Kamera',
                      onTap: () async => pickImage(ImageSource.camera),
                    ),
                  ],
                )
              else
                CircleAvatar(
                  radius: context.cLargeValue * 2,
                  backgroundImage: FileImage(image!),
                ),

              const Spacer(),
              if (image != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'İptal',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: context.cLowValue),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        await context.read<ProfileCubit>().confirmPickedImage(
                          image,
                        );
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Onayla',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: context.cLowValue),
            ],
          ),
        ),
      ),
    );
  }
}

/// Button widget for image source selection with custom styling.
class _ImageOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageOptionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  /// Builds the image option button with icon and label.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.38,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.05),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
