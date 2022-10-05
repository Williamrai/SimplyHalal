// final double? rating;
//   final String? phone;
//   final String id;
//   final String? alias;
//   @JsonKey(name: "is_closed")
//   final bool isClosed;
//   final List<Categories?> categories;
//   final String name;
//   final String url;
//   @JsonKey(name: "image_url")
//   final String imageUrl;
//   final Coordinates coordinates;
final String tableBusiness = 'business';

class BusinessFields {
  static final List<String> values = [
    id,
    rating,
    phone,
    alias,
    isClosed,
    name,
    websiteUrl,
    imageUrl,
    latitude,
    longitude
  ];
  static final String id = '_id';
  static final String rating = 'rating';
  static final String phone = 'phone';
  static final String alias = 'alias';
  static final String isClosed = 'isClosed';
  static final String name = 'name';
  static final String websiteUrl = 'websiteUrl';
  static final String imageUrl = 'imageUrl';
  static final String latitude = "latitude";
  static final String longitude = "longitude";
}
