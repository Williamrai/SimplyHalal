// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      rating: (json['rating'] as num?)?.toDouble(),
      phone: json['phone'] as String?,
      id: json['id'] as String,
      alias: json['alias'] as String?,
      isClosed: json['is_closed'] as bool,
      categories: (json['categories'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      url: json['url'] as String,
      imageUrl: json['image_url'] as String,
      coordinates:
          Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'rating': instance.rating,
      'phone': instance.phone,
      'id': instance.id,
      'alias': instance.alias,
      'is_closed': instance.isClosed,
      'categories': instance.categories.map((e) => e?.toJson()).toList(),
      'name': instance.name,
      'url': instance.url,
      'image_url': instance.imageUrl,
      'coordinates': instance.coordinates.toJson(),
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      alias: json['alias'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'title': instance.title,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
