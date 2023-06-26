// 管理token的获取和更新
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tada_video/generated/l10n.dart';

class TokenManager {
  static const String _tokenKey = 'token';
  static const String _expiredTimeKey = 'expiredTime';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<String?> getToken() async {
    return _prefs?.getString(_tokenKey);
  }

  static Future<void> saveToken(String token, int expiredTime) async {
    final SharedPreferences prefs = _prefs!;
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_expiredTimeKey, expiredTime);
  }

  static Future<void> deleteToken() async {
    final SharedPreferences prefs = _prefs!;
    await prefs.remove(_tokenKey);
    await prefs.remove(_expiredTimeKey);
  }

  static bool isTokenExpired() {
    final SharedPreferences prefs = _prefs!;
    final String? token = prefs.getString(_tokenKey);
    final int? expiredTime = prefs.getInt(_expiredTimeKey);
    if (token != null && expiredTime != null) {
      final DateTime now = DateTime.now();
      final DateTime expired = DateTime.fromMillisecondsSinceEpoch(expiredTime);
      return now.isAfter(expired);
    } else {
      return true;
    }
  }
}
