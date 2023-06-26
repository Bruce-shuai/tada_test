import 'package:get/get.dart';

import '../api/api_provider.dart';

class ProfileController extends GetxController {
  final api = ApiProvider();

  RxList<Map<String, String>> uploadVideos = RxList<Map<String, String>>([]);

  // 获取 uploadVideos
  Future<void> getUploadVideos(int index, int size) async {
    final response = await api.getUploadVideos(index, size);
    if (response.statusCode == 200) {
      final responseData = response.data['data'];

      List<Map<String, String>> videos = [];

      for (int i = 0; i < responseData.length; i++) {
        Map<String, String> video = {
          'mediaId': responseData[i]['media_id'],
          'posterUrl': responseData[i]['poster_url'],
          'videoUrl': responseData[i]['video_url'],
        };
        videos.add(video);
      }
      uploadVideos.addAll(videos);
    }
  }
}
