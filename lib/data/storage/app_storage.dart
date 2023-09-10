// // ignore_for_file: constant_identifier_names

// import 'dart:convert';

// import 'package:flutter_chat_sdk/data/api/models/responses/user.dart';
// import 'package:flutter_chat_sdk/res/language/localization_service.dart';
// import 'package:flutter_chat_sdk/res/theme/theme_service.dart';
// import 'package:get_storage/get_storage.dart';

// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  late SharedPreferences _pref;
  static const ROLE = "role";
  static const ACCESS_TOKEN = "access_token";

  static final AppStorage instance = AppStorage._internal();

  factory AppStorage() {
    return instance;
  }

  AppStorage._internal();

  init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> saveRoleUser({required String role}) async {
    _pref.setString(ROLE, role);
  }

  Future<String?> getRoleUser() async {
    final token = _pref.getString(ROLE);
    return token;
  }

  Future<void> saveUserAccessToken(String accessToken) async {
    _pref.setString(ACCESS_TOKEN, accessToken);
  }

  Future<String?> getUserAccessToken() async {
    final token = _pref.getString(ACCESS_TOKEN);
    return token;
  }

  clearRole() async{
    _pref.remove(ROLE);
  }

  clearAccessToken() async{
    _pref.remove(ACCESS_TOKEN);
  }

//   Future<void> saveUserInfo(User user) async {
//     String json = jsonEncode(user.toJson());
//     _pref.write(USER_INFO, json);
//   }

//   Future<User?> getUserInfo() async {
//     final userJson = await _pref.read(USER_INFO);
//     return userJson != null ? User.fromJson(json.decode(userJson)) : null;
//   }

//   // Future<void> saveSystemConfig(SystemConfig config) async {
//   //   String json = jsonEncode(config.toJson());
//   //   _pref.write(SYSTEM_CONFIG_DATA, json);
//   // }

//   // Future<SystemConfig?> getSystemConfig() async {
//   //   final config = await _pref.read(SYSTEM_CONFIG_DATA);
//   //   return config != null ? SystemConfig.fromJson(json.decode(config)) : null;
//   // }

//   Future<void> saveInstall(bool isInstall) async {
//     _pref.write(APP_NEW_INSTALL, isInstall);
//   }

//   Future<bool> isInstall() async {
//     final isInstall = await _pref.read(APP_NEW_INSTALL) ?? false;
//     return isInstall;
//   }

//   Future<void> setTheme(int theme) async {
//     _pref.write(APP_THEME, theme);
//   }

//   Future<int> getTheme() async {
//     final theme = await _pref.read(APP_THEME) ?? ThemeService.LIGHT_THEME;
//     return theme;
//   }

//   Future<void> setLanguage(String language) async {
//     _pref.write(APP_LANGUAGE, language);
//   }

//   Future<String> getLanguage() async {
//     final theme = await _pref.read(APP_LANGUAGE) ?? LANGUAGES[0].key;
//     return theme;
//   }

//   Future<void> logout() async {
//     if (_pref.hasData(APP_LANGUAGE)) await _pref.remove(APP_LANGUAGE);
//     if (_pref.hasData(APP_THEME)) await _pref.remove(APP_THEME);
//     if (_pref.hasData(USER_INFO)) await _pref.remove(USER_INFO);
//     if (_pref.hasData(USER_ACCESS_TOKEN)) await _pref.remove(USER_ACCESS_TOKEN);
//   }
}
