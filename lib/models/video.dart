class Video {
  String uid;
  String mediaId;
  int likes;
  int shares;
  int views;
  String caption;
  String videoUrl;
  // bool isLiked;

  Video({
    required this.uid,
    required this.mediaId,
    required this.likes,
    required this.shares,
    required this.views,
    // required this.isLiked,
    required this.caption,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      uid: json['user_id'] as String,
      mediaId: json['media_id'] as String,
      likes: json['likes'] as int,
      shares: json['shares'] as int,
      views: json['views'] as int,
      // isLiked: json['isLiked'] as bool,
      caption: json['caption'] as String,
      videoUrl: json['video_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'mediaId': mediaId,
        'likes': likes,
        'shares': shares,
        'views': views,
        // 'isLiked': isLiked,
        'videoUrl': videoUrl,
        'caption': caption,
      };
}
