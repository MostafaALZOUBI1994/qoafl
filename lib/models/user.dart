class User {
  int userId;
  String accessToken;
  String tokenType;
  String expiresAt;
  UserInfo userInfo;

  User({this.accessToken, this.tokenType, this.expiresAt, this.userInfo,this.userId});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    userId=json["user"]["id"];
    userInfo = json['user'] != null
        ? new UserInfo.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    if (this.userInfo != null) {
      data['user'] = this.userInfo.toJson();
    }
    return data;
  }
}

class UserInfo {
  int id;
  String type;
  String name;
  String email;
  String avatar;
  String avatarOriginal;
  String address;
  String country;
  String city;
  String postalCode;
  String phone;

  UserInfo(
      {this.id,
        this.type,
        this.name,
        this.email,
        this.avatar,
        this.avatarOriginal,
        this.address,
        this.country,
        this.city,
        this.postalCode,
        this.phone});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    return data;
  }
}