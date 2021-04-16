import 'package:qawafel/models/product.dart';

class ItemInCart {
  int id;
  Product product;
  String variation;
  var price;
  var tax;
  var shippingCost;
  int quantity;
  String date;

  ItemInCart(
      {this.id,
        this.product,
        this.variation,
        this.price,
        this.tax,
        this.shippingCost,
        this.quantity,
        this.date});

  ItemInCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    variation = json['variation'];
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['variation'] = this.variation;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['quantity'] = this.quantity;
    data['date'] = this.date;
    return data;
  }
}

