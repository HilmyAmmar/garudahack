// lib/models/forum_post.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forum_post.freezed.dart';
part 'forum_post.g.dart';

@freezed
class ForumPost with _$ForumPost {
  const factory ForumPost({
    required String title,
    required String author,
    required String content,
    required String info1,
    required String info2,
    required String tag,
  }) = _ForumPost;

  factory ForumPost.fromJson(Map<String, dynamic> json) =>
      _$ForumPostFromJson(json);
}
