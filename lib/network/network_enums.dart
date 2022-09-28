enum NetworkResponseErrorType { socket, exception, reponseEmpty, didNotSucceed }

enum CallBackParameterName {
  allBusiness,
  businessDetails,
}

extension CallBackParameterNameExtension on CallBackParameterName {
  dynamic getJson(json) {
    if (json == null) return null;
    switch (this) {
      case CallBackParameterName.allBusiness:
        return json['businesses'];
      case CallBackParameterName.businessDetails:
        // some logic should be place here to return the details of the chosen business
        return json;
    }
  }
}
