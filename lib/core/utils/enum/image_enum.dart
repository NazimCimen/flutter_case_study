enum ImageEnums {
  logo,
  auth_back,
  forget_password,
  refresh_password,

  flag_turkiye,
  flag_en,
  ic_email,
  ic_password,
  ic_google,
  ic_apple,
  ic_nameSurname,
  ic_home,
  ic_profile,
  ic_facebook,
  ic_offer,
  ic_sheet1,
  ic_sheet2,
  ic_sheet3,
  ic_sheet4,
  bg_splash,
  bg_sheet_icon,
  movie_default_logo,
  sheet_shadow,
}

extension AssetExtension on ImageEnums {
  String get toPathPng => 'assets/images/$name.png';
}
