// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forum_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ForumPost _$ForumPostFromJson(Map<String, dynamic> json) {
  return _ForumPost.fromJson(json);
}

/// @nodoc
mixin _$ForumPost {
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get info1 => throw _privateConstructorUsedError;
  String get info2 => throw _privateConstructorUsedError;
  String get tag => throw _privateConstructorUsedError;

  /// Serializes this ForumPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumPostCopyWith<ForumPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumPostCopyWith<$Res> {
  factory $ForumPostCopyWith(ForumPost value, $Res Function(ForumPost) then) =
      _$ForumPostCopyWithImpl<$Res, ForumPost>;
  @useResult
  $Res call({
    String title,
    String author,
    String content,
    String info1,
    String info2,
    String tag,
  });
}

/// @nodoc
class _$ForumPostCopyWithImpl<$Res, $Val extends ForumPost>
    implements $ForumPostCopyWith<$Res> {
  _$ForumPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? content = null,
    Object? info1 = null,
    Object? info2 = null,
    Object? tag = null,
  }) {
    return _then(
      _value.copyWith(
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            author:
                null == author
                    ? _value.author
                    : author // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            info1:
                null == info1
                    ? _value.info1
                    : info1 // ignore: cast_nullable_to_non_nullable
                        as String,
            info2:
                null == info2
                    ? _value.info2
                    : info2 // ignore: cast_nullable_to_non_nullable
                        as String,
            tag:
                null == tag
                    ? _value.tag
                    : tag // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumPostImplCopyWith<$Res>
    implements $ForumPostCopyWith<$Res> {
  factory _$$ForumPostImplCopyWith(
    _$ForumPostImpl value,
    $Res Function(_$ForumPostImpl) then,
  ) = __$$ForumPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String author,
    String content,
    String info1,
    String info2,
    String tag,
  });
}

/// @nodoc
class __$$ForumPostImplCopyWithImpl<$Res>
    extends _$ForumPostCopyWithImpl<$Res, _$ForumPostImpl>
    implements _$$ForumPostImplCopyWith<$Res> {
  __$$ForumPostImplCopyWithImpl(
    _$ForumPostImpl _value,
    $Res Function(_$ForumPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? content = null,
    Object? info1 = null,
    Object? info2 = null,
    Object? tag = null,
  }) {
    return _then(
      _$ForumPostImpl(
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        author:
            null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        info1:
            null == info1
                ? _value.info1
                : info1 // ignore: cast_nullable_to_non_nullable
                    as String,
        info2:
            null == info2
                ? _value.info2
                : info2 // ignore: cast_nullable_to_non_nullable
                    as String,
        tag:
            null == tag
                ? _value.tag
                : tag // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumPostImpl implements _ForumPost {
  const _$ForumPostImpl({
    required this.title,
    required this.author,
    required this.content,
    required this.info1,
    required this.info2,
    required this.tag,
  });

  factory _$ForumPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumPostImplFromJson(json);

  @override
  final String title;
  @override
  final String author;
  @override
  final String content;
  @override
  final String info1;
  @override
  final String info2;
  @override
  final String tag;

  @override
  String toString() {
    return 'ForumPost(title: $title, author: $author, content: $content, info1: $info1, info2: $info2, tag: $tag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumPostImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.info1, info1) || other.info1 == info1) &&
            (identical(other.info2, info2) || other.info2 == info2) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, author, content, info1, info2, tag);

  /// Create a copy of ForumPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumPostImplCopyWith<_$ForumPostImpl> get copyWith =>
      __$$ForumPostImplCopyWithImpl<_$ForumPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumPostImplToJson(this);
  }
}

abstract class _ForumPost implements ForumPost {
  const factory _ForumPost({
    required final String title,
    required final String author,
    required final String content,
    required final String info1,
    required final String info2,
    required final String tag,
  }) = _$ForumPostImpl;

  factory _ForumPost.fromJson(Map<String, dynamic> json) =
      _$ForumPostImpl.fromJson;

  @override
  String get title;
  @override
  String get author;
  @override
  String get content;
  @override
  String get info1;
  @override
  String get info2;
  @override
  String get tag;

  /// Create a copy of ForumPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumPostImplCopyWith<_$ForumPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
