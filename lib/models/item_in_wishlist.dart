import 'package:qawafel/models/product.dart';

class ItemInWishList {
  int id;
  Product product;

  ItemInWishList({this.id, this.product});

  ItemInWishList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

