class Seller {
  String name;
  String email;
  String avatar;
  String avatarOriginal;
  String shopName;
  String shopLogo;
  String shopLink;

  Seller(
      {this.name,
        this.email,
        this.avatar,
        this.avatarOriginal,
        this.shopName,
        this.shopLogo,
        this.shopLink});

  Seller.fromJson(Map<String, dynamic> json) {
    name = json['name'] !=null? json['name'] :"";
    email = json['email'] !=null? json['email'] :"";
    avatar = json['avatar'] !=null? json['avatar'] :"";
    avatarOriginal = json['avatar_original'] !=null? json['avatar_original'] :"";
    shopName = json['shop_name'] !=null? json['shop_name'] :"";
    shopLogo = json['shop_logo'] !=null? json['shop_logo'] :"";
    shopLink = json['shop_link'] !=null? json['shop_link'] :"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    data['shop_link'] = this.shopLink;
    return data;
  }
}