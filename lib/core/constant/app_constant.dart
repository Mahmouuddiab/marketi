import 'package:marketi/core/cache/cache_helper.dart';

abstract class AppConstant {
  static Future<String?> token =  CacheHelper.getToken();
  static const String baseUrl = "https://supermarket-dan1.onrender.com/api/v1/";
  static const String register = "${baseUrl}auth/signUp";
  static const String login = "${baseUrl}auth/signIn";
}