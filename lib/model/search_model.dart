class SearchModel {
  String? id;
  String businessName;

  SearchModel({
    required this.id,
    required this.businessName,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        businessName: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {'name': businessName, 'id': id};
}
