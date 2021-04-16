class AddressModel {
  int id;
  String address;
  String country;
  String city;
  String postalCode;
  String phone;
  int setDefault;

  AddressModel(
      {this.id,

        this.address,
        this.country,
        this.city,
        this.postalCode,
        this.phone,
        this.setDefault});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'] ?? " ";
    country = json['country'] ?? " ";
    city = json['city']?? " ";
    postalCode = json['postal_code']?? " ";
    phone = json['phone']?? " ";
    setDefault = json['set_default']?? " ";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['set_default'] = this.setDefault;
    return data;
  }
}