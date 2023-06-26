import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'token_manager.dart';

class ApiProvider {
  // 创建单例
  static final ApiProvider _instance = ApiProvider._();
  final Dio _dio = Dio();

  ApiProvider._() {
    _dio.options.baseUrl = 'https://tada.mytada.services';
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // 添加请求拦截器
      final token = await TokenManager.getToken();
      if (token != null) {
        options.headers['Authorization'] = '$token';
      }
      handler.next(options);
    }, onResponse: (response, handler) {
      // 添加响应拦截器
      handler.next(response);
    }, onError: (error, handler) {
      // 处理请求异常
      handler.next(error);
    }));
  }

  factory ApiProvider() => _instance;

  Future<String> thirdLogin(String id) async {
    final data = jsonEncode({'id': id});
    final response = await _dio.post('/third/party/login', data: data);
    if (response.statusCode == 200) {
      final token = response.data['token'];
      await TokenManager.saveToken(token, 3);
      return token!;
    } else {
      throw Exception('login error');
    }
  }

  Future<Response> upLoadVideo(File videoFile, String caption) async {
    final formData = FormData.fromMap({
      'file':
          await MultipartFile.fromFile(videoFile.path, filename: 'upload.mp4'),
      'caption': caption
    });
    final response = await _dio.post('/media/upload', data: formData);
    return response;
  }

  Future<Response> getUploadVideos(int index, int size) async {
    final response = await _dio.get('/media/assets/list',
        queryParameters: {"index": index, "size": size});
    return response;
  }

  Future<Response> addMediaLike(String mediaId) async {
    final response =
        await _dio.post('/media/like', queryParameters: {"media_id": mediaId});
    return response;
  }

  Future<Response> removeMediaLike(String mediaId) async {
    final response = await _dio
        .post('/media/unlike', queryParameters: {"media_id": mediaId});
    return response;
  }

  Future<Response> addMediaView(String mediaId) async {
    final response =
        await _dio.post('/media/view', queryParameters: {"media_id": mediaId});
    return response;
  }

  Future<Response> getMediaInfo(String mediaId) async {
    final response =
        await _dio.get('/media/info', queryParameters: {"media_id": mediaId});
    print('xxx');
    return response;
  }

  Future<Response> getMediaContentList(int size) async {
    final response =
        await _dio.get('/media/contents/list', queryParameters: {"size": size});
    return response;
  }

  Future<Response> changeUserNickname(String nickname) async {
    final response = await _dio
        .post('/user/upload/nickname', queryParameters: {"nickname": nickname});
    return response;
  }

  Future<Response> changeUserAvatar(File avatarFile) async {
    final formData = FormData.fromMap({
      'file':
          await MultipartFile.fromFile(avatarFile.path, filename: 'upload.jpg'),
    });
    final response = await _dio.post('/user/upload/avatar', data: formData);
    return response;
  }

  Future<Response> getUserAvatar() async {
    final response = await _dio.get('/user/info/avatar');
    return response;
  }
}
