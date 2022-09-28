class SimplyHalalApiParam {
  const SimplyHalalApiParam._();

  static Map<String, String> apiQuery(
          {required String location, String categories = 'halal'}) =>
      {'location': location, 'categories': categories};
}
