import 'dart:io';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:case_study/core/size/constant_size.dart';

/// Bottom sheet widget for changing profile image with camera or gallery options.
class UploadProfileImageSheet extends StatefulWidget {
  const UploadProfileImageSheet({super.key});

  @override
  State<UploadProfileImageSheet> createState() =>
      _UploadProfileImageSheetState();
}

class _UploadProfileImageSheetState extends State<UploadProfileImageSheet> {
  File? image;

  /// Picks image from camera or gallery and crops it to square aspect ratio.
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: StringConstants.profileImageCropTitle,
            toolbarColor: AppColors.background,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            statusBarColor: AppColors.background,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: StringConstants.profileImageCropTitle,
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      if (croppedFile != null) {
        image = File(croppedFile.path);
      }
      if (mounted) {
        Navigator.pop(context, image);
      }
    }
  }

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
              ),

              const Spacer(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
