class FavoriteModel {
  int? id;
  String imageUrl;
  String businessName;
  double distance;

  FavoriteModel({
    required this.imageUrl,
    required this.businessName,
    required this.distance,
    this.id,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        imageUrl: json['image_url'],
        businessName: json['name'],
        distance: json['distance'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'name': businessName,
        'distance': distance,
        'id': id
      };
}
