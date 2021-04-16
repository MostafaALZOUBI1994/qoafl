class Category {
  String name;
  String banner;
  String icon;
  int numberOfChildren;
  Links links;

  Category(
      {this.name, this.banner, this.icon, this.numberOfChildren, this.links});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    banner = json['banner'];
    icon = json['icon'];
    numberOfChildren = json['number_of_children'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['banner'] = this.banner;
    data['icon'] = this.icon;
    data['number_of_children'] = this.numberOfChildren;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Links {
  String products;
  String subCategories;

  Links({this.products, this.subCategories});

  Links.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    subCategories = json['sub_categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products'] = this.products;
    data['sub_categories'] = this.subCategories;
    return data;
  }
}
