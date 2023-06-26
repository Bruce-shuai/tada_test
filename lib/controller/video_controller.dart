import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../api/api_provider.dart';
import '../models/video.dart';

class VideoController extends GetxController {
  final RxList<Video> _videoList = RxList<Video>([]);
  final Rx<VideoPlayerController?> _videoPlayerController =
      Rx<VideoPlayerController?>(null);

  List<Video> get videoList => _videoList.value;

  VideoPlayerController? get videoPlayerController =>
      _videoPlayerController.value;

  void setVideoPlayerController(VideoPlayerController? controller) {
    _videoPlayerController.value = controller;
  }

  void setVideoList(List<Video> videoList) {
    _videoList.value = videoList;
    update();
  }

  // 获取视频列表id
  Future<List<String>> getMediaContentList(int size) async {
    final response = await ApiProvider().getMediaContentList(size);
    if (response.statusCode == 200) {
      final data = response.data['data'];
      final mediaIds =
          List<String>.from(data.map((item) => item['media_id'].toString()));
      return mediaIds;
    } else {
      throw Exception('Error getting media content list');
    }
  }

  // 基于视频id获取视频信息
  Future<Video> getMediaInfo(String mediaId) async {
    print('aaaa');
    print(mediaId);
    final response = await ApiProvider().getMediaInfo(mediaId);
    print(response);
    if (response.statusCode == 200) {
      final data = response.data['data'];
      final video = Video.fromJson(data);
      return video;
    } else {
      throw Exception('Error getting video info');
    }
  }

  // 给视频点赞
  Future<void> likeVideo(Video video) async {
    try {
      final response = await ApiProvider().addMediaLike(video.mediaId);
      if (response.statusCode == 200) {
        // video.isLiked = true;
        video.likes++;
        _videoList.refresh();
      }
    } catch (e) {
      print('Error liking video: $e');
    }
  }

  // 取消视频点赞
  Future<void> unlikeVideo(Video video) async {
    try {
      final response = await ApiProvider().removeMediaLike(video.mediaId);
      if (response.statusCode == 200) {
        // video.isLiked = false;
        video.likes--;
        _videoList.refresh();
      }
    } catch (e) {
      print('Error unliking video: $e');
    }
  }
}
