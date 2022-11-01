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
  final String id;
  final String name;
  @JsonKey(name: "image_url")
  final String imageUrl;
  final double? rating;
  final String? url;
  final double? distance;

  Business(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.rating,
      required this.url,
      required this.distance});

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);

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
