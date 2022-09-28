import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'business.g.dart';

/*
 * When you create any model 
 * - first create a class and add all the fields requried 
 * - the create the factory classes fromJson and toJson
 * - then run the command flutter pub run build_runner build
 * - in order for this to work you need to add following dependencies 
 *    -  json_annotation: ^4.7.0
 *    - build_runner: ^2.2.1
 *    - json_serializable: ^6.4.0
 */
@JsonSerializable(explicitToJson: true)
class Business {
  final double? rating;
  final String? phone;
  final String id;
  final String? alias;
  @JsonKey(name: "is_closed")
  final bool isClosed;
  final List<Categories?> categories;
  final String name;
  final String url;
  @JsonKey(name: "image_url")
  final String imageUrl;
  final Coordinates coordinates;

  Business(
      {required this.rating,
      required this.phone,
      required this.id,
      required this.alias,
      required this.isClosed,
      required this.categories,
      required this.name,
      required this.url,
      required this.imageUrl,
      required this.coordinates});

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}

@JsonSerializable()
class Categories {
  final String? alias;
  final String? title;

  Categories({required this.alias, required this.title});

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable()
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
