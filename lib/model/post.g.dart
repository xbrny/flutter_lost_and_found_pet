// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    postType: _$enumDecodeNullable(_$PostTypeEnumMap, json['postType']),
    name: json['name'] as String,
    breed: json['breed'] as String,
    location: json['location'] as String,
    notifyMe: json['notifyMe'] as bool,
    dateTimeLost: json['dateTimeLost'] == null
        ? null
        : DateTime.parse(json['dateTimeLost'] as String),
    phoneNumber: json['phoneNumber'] as String,
    additionalDetails: json['additionalDetails'] as String,
  )
    ..id = json['id'] as String
    ..imageUrl = (json['imageUrl'] as List)?.map((e) => e as String)?.toList()
    ..uid = json['uid'] as String
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'postType': _$PostTypeEnumMap[instance.postType],
      'name': instance.name,
      'breed': instance.breed,
      'location': instance.location,
      'notifyMe': instance.notifyMe,
      'dateTimeLost': instance.dateTimeLost?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'additionalDetails': instance.additionalDetails,
      'imageUrl': instance.imageUrl,
      'uid': instance.uid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$PostTypeEnumMap = <PostType, dynamic>{
  PostType.lost: 'lost',
  PostType.found: 'found'
};
