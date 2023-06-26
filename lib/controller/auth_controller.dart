import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tada_video/api/google_signin_api.dart';
import '../api/api_provider.dart';

class AuthController extends GetxController {
  var api = ApiProvider(); // 创建 ApiProvider 实例

  var isSuccess = false.obs;
  var isLoading = false.obs;

  Future googleSignIn() async {
    try {
      isLoading.value = true;
      await GoogleSignInApi.login();
      isSuccess.value = true;
    } catch (e) {
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
