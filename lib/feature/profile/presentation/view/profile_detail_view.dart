import 'dart:io';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/product/widgets/custom_button.dart';
import 'package:case_study/feature/profile/presentation/widget/custom_profile_appbar.dart';
import 'package:case_study/feature/profile/presentation/widget/upload_profile_image_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_state.dart';

class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: const CustomProfileAppBar(),
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final selectedImage = state is ProfileImageUpdated
                  ? state.image
                  : null;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.cMediumValue * 2,
                ),
                child: Column(
                  children: [
                    SizedBox(height: context.cLargeValue * 2),

                    // Title text
                    Text(
                      StringConstants.uploadPhotosTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(height: context.cMediumValue),

                    // Subtitle text
                    Text(
                      StringConstants.uploadPhotosSubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),

                    SizedBox(height: context.cLargeValue * 3),

                    // Upload area
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showPickImageSheet(context).then((value) {
                            if (context.mounted) {
                              if (value is File?) {
                                context.read<ProfileCubit>().confirmPickedImage(
                                  value,
                                );
                              }
                            }
                          });
                        },
                        child: Container(
                          width: 165,
                          height: 165,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(31),
                            border: Border.all(
                              color: AppColors.white.withOpacity(0.1),
                              width: 1.55,
                            ),
                          ),
                          child: selectedImage == null
                              ? Icon(
                                  Icons.add,
                                  size: context.cXLargeValue,
                                  color: AppColors.white.withOpacity(0.5),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(31),
                                  child: Image.file(
                                    selectedImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Action buttons
                    if (selectedImage != null)
                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonWidget(
                              onPressed: () {
                                _showPickImageSheet(context).then((value) {
                                  if (context.mounted) {
                                    if (value is File?) {
                                      context
                                          .read<ProfileCubit>()
                                          .confirmPickedImage(value);
                                    }
                                  }
                                });
                              },
                              text: 'Değiştir',
                            ),
                          ),
                          SizedBox(width: context.cMediumValue),
                          Expanded(
                            child: CustomButtonWidget(
                              onPressed: () {
                                context
                                    .read<ProfileCubit>()
                                    .removeProfileImage();
                              },
                              text: 'Kaldır',
                            ),
                          ),
                        ],
                      ),

                    SizedBox(height: context.cMediumValue),
                    CustomButtonWidget(
                      onPressed: () {
                        context.read<ProfileCubit>().updateProfileImage(
                          selectedImage,
                        );
                      },
                      text: StringConstants.continueButton,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showPickImageSheet(BuildContext context) {
    return showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const UploadProfileImageSheet(),
        );
      },
    );
  }
}
