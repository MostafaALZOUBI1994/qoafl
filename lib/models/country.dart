class Country {
  String code;
  String name;
  String isoCode;
  bool stateRequired;
  bool postCodeRequired;
  String internationalCallingNumber;

  Country({this.code, this.name, this.isoCode, this.stateRequired, this.postCodeRequired, this.internationalCallingNumber});

  Country.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
    isoCode = json['IsoCode'];
    stateRequired = json['StateRequired'];
    postCodeRequired = json['PostCodeRequired'];
    internationalCallingNumber = json['InternationalCallingNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['IsoCode'] = this.isoCode;
    data['StateRequired'] = this.stateRequired;
    data['PostCodeRequired'] = this.postCodeRequired;
    data['InternationalCallingNumber'] = this.internationalCallingNumber;
    return data;
  }
}

