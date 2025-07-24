// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForumPostImpl _$$ForumPostImplFromJson(Map<String, dynamic> json) =>
    _$ForumPostImpl(
      title: json['title'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      info1: json['info1'] as String,
      info2: json['info2'] as String,
      tag: json['tag'] as String,
    );

Map<String, dynamic> _$$ForumPostImplToJson(_$ForumPostImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'content': instance.content,
      'info1': instance.info1,
      'info2': instance.info2,
      'tag': instance.tag,
    };
