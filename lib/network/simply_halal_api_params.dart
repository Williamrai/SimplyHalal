class SimplyHalalApiParam {
  const SimplyHalalApiParam._();

  static Map<String, String> apiQuery(
          {required String location, String categories = 'halal'}) =>
      {'location': location, 'categories': categories};

  static Map<String, String> searchQuery({required String businessName}) =>
      {'term': businessName};
}
