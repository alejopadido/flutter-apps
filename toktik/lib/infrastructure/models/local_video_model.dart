import 'package:toktik/domain/entities/video_post.dart';

class LocalVideoModel {
  final String caption;
  final String videoUrl;
  final int likes;
  final int views;

  LocalVideoModel({
    required this.caption,
    required this.videoUrl,
    required this.likes,
    required this.views,
  });

  factory LocalVideoModel.mapFromJson(Map<String, dynamic> json) =>
      LocalVideoModel(
        caption: json['name'] ?? 'No caption',
        videoUrl: json['videoUrl'],
        likes: json['likes'],
        views: json['views'],
      );

  VideoPost toVideoPostEntity() => VideoPost(
      caption: caption, videoUrl: videoUrl, likes: likes, views: views);
}




//toVideoPostEntity