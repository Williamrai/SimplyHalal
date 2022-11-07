class SearchModel {
  String businessName;

  SearchModel({
    required this.businessName,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        businessName: json['name'],
      );

  Map<String, dynamic> toJson() => {'name': businessName};
}
