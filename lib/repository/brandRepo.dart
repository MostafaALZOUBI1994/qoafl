import 'dart:convert';

import 'package:qawafel/constants.dart';

import 'package:http/http.dart' as http;
import 'package:qawafel/models/brand.dart';

class BrandRepo {
  Future<List<Brand>> fetchTopBrands() async {
    try{
    List<Brand> topBrands = [];
    var url = Uri.parse(baseUrl + "/brands/top");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data["data"]
          .map((brand) => topBrands.add(Brand.fromJson(brand)))
          .toList();
      return topBrands;
    }}catch(ex){
      print(ex.toString());
    }
  }

  Future<List<Brand>> fetchAllBrands() async {
    try{
      List<Brand> allBrands = [];
      var url = Uri.parse(baseUrl + "/brands");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((brand) => allBrands.add(Brand.fromJson(brand)))
            .toList();
        return allBrands;
      }}catch(ex){
      print(ex.toString());
    }
  }
}
