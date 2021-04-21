import 'package:qawafel/models/brand.dart';
import 'package:qawafel/models/seller.dart';
import 'package:qawafel/models/user.dart';
import 'category.dart';

class Product {
  int id;
  String name;
  String addedBy;
  Seller seller;
  Category category;
  Brand brand;
  List<dynamic> photos;
  String thumbnailImage;
  List<String> tags;
  var priceLower;
  var priceHigher;
  //List<Null> choiceOptions;
  //Null colors;
  int currentStock;
  //Null unit;
  var basePrice;
  var baseDiscountedPrice;
  int todaysDeal;
  int featured;
  String unit;
  int discount;
  String discountType;
  int rating;
  int sales;
  Links links;
  int tax;
  String taxType;
  String shippingType;
  int shippingCost;
  int numberOfSales;
  String video;
  int ratingCount;
  String description;
  String image;
  List isExistInCart;
  List isExistInWishList;
  List stocks;
  Product({
    this.id,
    this.name,
    this.addedBy,
    //this.user,
    this.category,
    this.brand,
    this.photos,
    this.thumbnailImage,
    this.tags,
    this.priceLower,
    this.priceHigher,
    this.basePrice,
    this.rating,
    this.baseDiscountedPrice,
    this.currentStock,
    this.description,
    this.discount,
    this.discountType,
    this.featured,
    this.links,
    this.numberOfSales,
    this.ratingCount,
    this.sales,
    this.shippingCost,
    this.shippingType,
    this.tax,
    this.taxType,
    this.todaysDeal,
    this.image,
    this.video,
    this.isExistInCart,
    this.isExistInWishList,
    this.unit,this.stocks,
    //   this.choiceOptions,
    // this.colors,

    // this.unit,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addedBy = json['added_by'];
    seller = json['user'] != null ? new Seller.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    photos = json['photos_list'] != null ? photos = json['photos_list'] : [];
    thumbnailImage = json['thumbnail_image'];
    tags = json['tags'] != null ? [] : tags = json['tags'];
    priceLower = json['price_lower'];
    priceHigher = json['price_higher'];
    todaysDeal = json['todays_deal'];
    featured = json['featured'];
    currentStock = json['current_stock'];
    discount = json['discount'];
    discountType = json['discount_type'];
    tax = json['tax'];
    taxType = json['tax_type'];
    shippingType = json['shipping_type'];
    shippingCost = json['shipping_cost'];
    numberOfSales = json['number_of_sales'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    description = json['description'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    basePrice = json['base_price'];
    baseDiscountedPrice = json['base_discounted_price'];
    unit = json['unit'];
    sales = json['sales'];
    video = json["video"];
    isExistInWishList = json["is_wishlist"];
    isExistInCart = json["is_cart"];
    image = json['image'];
    stocks= json["stocks"];
    /*
    if (json['choice_options'] != null) {
      choiceOptions = new List<Null>();
      json['choice_options'].forEach((v) {
        choiceOptions.add(new Null.fromJson(v));
      });
    }
    colors = json['colors'];
    unit = json['unit'];
     */
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['added_by'] = this.addedBy;
    /*
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    */
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['photos'] = this.photos;
    data['thumbnail_image'] = this.thumbnailImage;
    data['tags'] = this.tags;
    data['price_lower'] = this.priceLower;
    data['price_higher'] = this.priceHigher;
    data['todays_deal'] = this.todaysDeal;
    data['featured'] = this.featured;
    data['current_stock'] = this.currentStock;

    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['shipping_type'] = this.shippingType;
    data['shipping_cost'] = this.shippingCost;
    data['number_of_sales'] = this.numberOfSales;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['description'] = this.description;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    /*
      if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions.map((v) => v.toJson()).toList();
    }
    data['colors'] = this.colors;
    data['unit'] = this.unit;
     */
    return data;
  }
}

class Links {
  String products;
  String subCategories;
  String details;
  String reviews;
  Links({this.products, this.subCategories, this.details, this.reviews});

  Links.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    subCategories = json['sub_categories'];
    details =
        json["details"] == null ? details = "" : details = json["details"];
    reviews =
        json["reviews"] == null ? reviews = "" : reviews = json["reviews"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products'] = this.products;
    data['sub_categories'] = this.subCategories;
    return data;
  }
}
