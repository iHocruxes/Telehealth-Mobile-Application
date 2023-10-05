// ignore_for_file: constant_identifier_names

class ApiConstants {
  // CLOUDINARY
  static const UPLOAD = '/upload';

// common
  static const _COMMON_USER = '/common/user';
  static const _COMMON_DOCTOR = '/common/doctor';

  /// dont need cookie
  static const USER_LOG_IN = '$_COMMON_USER/auth';
  static const DOCTOR_LOG_IN = '$_COMMON_DOCTOR/auth';

  /// need cookie
  static const USER_REFRESH_TOKEN = '$_COMMON_USER/refresh';
  static const USER_LOG_OUT = '$_COMMON_USER/logout';
  static const DOCTOR_REFRESH_TOKEN = '$_COMMON_DOCTOR/refresh';
  static const DOCTOR_LOG_OUT = '$_COMMON_DOCTOR/logout';

// user
  static const _USER = '/user-management';
  static const USER = '$_USER/user';
  static const MEDICAL_RECORD = '$_USER/medical-record';

// doctor
  static const _DOCTOR = '/doctor-management';
  static const DOCTOR = '$_DOCTOR/doctor';
  static const DOCTOR_CHANGE_AVATAR = '$DOCTOR/avatar';
  static const DOCTOR_CHANGE_BIOGRAPHY = '$DOCTOR/biography';
  static const DOCTOR_FEEDBACK = '$_DOCTOR/feeback';
  static const DOCTOR_GET_PUBLIC = '$_DOCTOR/public';
}
