import 'dart:io';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/feature/profile/presentation/widget/upload_profile_image_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:provider/provider.dart';

/// Mixin for refresh profile image sheet functionality.
mixin UploadProfileImageMixin on State<UploadProfileImageSheet> {
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
            toolbarTitle: 'StringConstants.profileImageCropTitle',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'StringConstants.profileImageCropTitle',
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      if (croppedFile != null) {
        image = File(croppedFile.path);
        setState(() {});
      }
    }
  }

  /// Uploads and updates profile image using ViewModel with error handling.
  Future<void> confirmImageUpload() async {
    //if (image == null) return;

    /*  final result = await context.read<ProfileViewModel>().updateProfileImage(
      imageFile: image!,
    );

    result.fold(
      (failure) {
        if (mounted) {
          CustomSnackBars.showCustomTopScaffoldSnackBar(
            context: context,
            text: failure.errorMessage,
            icon: Icons.error,
          );
        }
      },
      (success) {
        if (success && mounted) {
          CustomSnackBars.showCustomTopScaffoldSnackBar(
            context: context,
            text: StringConstants.profileImageUpdateSuccess,
            icon: Icons.check_circle,
          );
          context.read<MainLayoutViewModel>().loadUser();
          Navigator.pop(context, true);
        }
      },
    );*/
  }
}
