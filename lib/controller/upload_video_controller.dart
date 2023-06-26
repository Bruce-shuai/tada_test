import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tada_video/constants/route_constants.dart';
import 'package:video_player/video_player.dart';

import '../api/api_provider.dart';

class UploadVideoController extends GetxController {
  var api = ApiProvider();

  final picker = ImagePicker();
  Rx<VideoPlayerController> videoPlayerController =
      Rx<VideoPlayerController>(VideoPlayerController.file(File('')));
  Rx<XFile?> video = Rx<XFile?>(null);
  RxBool isUploading = false.obs;
  RxString description = ''.obs;

  // 初始化时调用
  @override
  void onInit() {
    super.onInit();
  }

  // 上传结束后调用
  @override
  void onClose() {
    super.onClose();
    videoPlayerController.value.seekTo(Duration.zero);
    videoPlayerController.value.dispose();
    videoPlayerController.value =
        VideoPlayerController.asset('assets/placeholder_video.mp4');
  }

  // 播放视频
  void play() {
    videoPlayerController.value.play();
  }

  // 暂停视频
  void pause() {
    videoPlayerController.value.pause();
  }

  // 打开相机或相册选择视频
  Future<void> selectVideo() async {
    final XFile? result = await picker.pickVideo(source: ImageSource.gallery);
    if (result != null) {
      await videoPlayerController.value.dispose();
      videoPlayerController.value =
          VideoPlayerController.file(File(result.path))
            ..initialize().then((value) => videoPlayerController.value.play());
      video.value = result;
    }
  }

  // 上传视频
  Future<void> upload() async {
    if (isUploading.value || video.value == null) {
      return;
    }
    isUploading.value = true;

    // 上传视频
    final response =
        await api.upLoadVideo(File(video.value!.path), description.value);

    // 处理上传成功后的逻辑，例如：跳转到视频详情页
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Upload video success');
      Get.toNamed(Routes.home);
    } else {
      // 上传失败，提示用户
      Get.snackbar('Error', 'Upload video failed');
    }

    // 上传结束后重置状态
    isUploading.value = false;
  }
}
