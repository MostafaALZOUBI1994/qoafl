import 'dart:convert';

import 'package:qawafel/constants.dart';
import 'package:qawafel/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryRepo {
  Future<List<Category>> fetchTopCategories() async {
    try {
      List<Category> topCategories = [];
      var url = Uri.parse(baseUrl + "/categories/top");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((category) => topCategories.add(Category.fromJson(category)))
            .toList();
        return topCategories;
      }
    }catch(ex){print(ex.toString());}

  }

  Future<List<Category>> fetchSubCategories(Category allSubs,String urlString) async{
    try {
      List<Category> subCategories = [];
      Category allChoice = Category(name: "االكل",
          links: allSubs.links,
          icon: allSubs.icon,
          banner: allSubs.banner,
          numberOfChildren: allSubs.numberOfChildren);
      subCategories.add(allChoice);
      var url = Uri.parse(urlString);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((subCategory) =>
            subCategories.add(Category.fromJson(subCategory)))
            .toList();

        return subCategories;
      }
    }catch(ex){print(ex.toString());}
  }
  Future<List<Category>> fetchAllCategories() async {
    try {
      List<Category> allCategories = [];
      var url = Uri.parse(baseUrl + "/categories");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((category) => allCategories.add(Category.fromJson(category)))
            .toList();
        return allCategories;
      }
    }catch(ex){print(ex.toString());}
  }

}
