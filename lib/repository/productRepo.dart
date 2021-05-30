import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:qawafel/models/item_in_cart.dart';
import 'package:qawafel/models/item_in_wishlist.dart';
import 'package:qawafel/ui/widgets/snakbar.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

class ProductRepo {
  Response response;
  var dio = new Dio();
  String accessToken = kUser==null? "" :kUser.accessToken ;
  BuildContext context;

  Future<List<String>> getBanners() async {
    BuildContext context;
    List<String> banners=[];
    try{
     response=await dio.get(baseUrl+"/sliders");
     response.data["data"].map((item) {
       banners.add(item["photo"]);
     }).toList();
     return banners;
    }catch(ex){showSnackBar(context,"get Banners "+ex.toString());}
  }

  Future<List<Product>> searchProductsByText(String searchText) async {
    try {
      List<Product> fillteredProducts = [];
      var url = Uri.parse(baseUrl + "/products/search?key=" + searchText);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => fillteredProducts.add(Product.fromJson(product)))
            .toList();

        return fillteredProducts;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<List<Product>> searchProductsByVoice(String voice) async {
    try{
      List<Product> fillteredProducts = [];
    dio.options.baseUrl = baseUrl;
    // dio.options.connectTimeout = 5000; //5s
    //dio.options.receiveTimeout = 5000;
    //dio.options.headers = <Header Json>;
    String fileName = basename(voice);
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(voice, filename: fileName),
      "rate": 32000,
      "language": "ar-SY"
    });

    var response = await dio.post(baseUrl + '/products/searchVoice',
        data: formData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
      if (response.statusCode == 200) {

       response.data
            .map((product) => fillteredProducts.add(Product.fromJson(product)))
            .toList();

        return fillteredProducts;
      }
    print(response.toString());}
    catch(ex){print("ssearch   "+ex.toString());}
  }

  Future<List<Product>> fetchAllProducts() async {
    try {
      List<Product> allProducts = [];
      var url = Uri.parse(baseUrl + "/products?page=1");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => allProducts.add(Product.fromJson(product)))
            .toList();

        return allProducts;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<List<Product>> fetchFlashDealsProducts() async {
    try {
      List<Product> allProducts = [];
      var url = Uri.parse(baseUrl + "/flash-deal-products/1");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => allProducts.add(Product.fromJson(product)))
            .toList();

        return allProducts;
      }
    } catch(ex){showSnackBar(context,"Flash Deals "+ex.toString());}
  }

  Future<List<Product>> fetchProductsByCategory(String urlString) async {
    try {
      List<Product> products = [];
      var url = Uri.parse(urlString);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => products.add(Product.fromJson(product)))
            .toList();
        return products;
      }
    } catch(ex){showSnackBar(context,"products by category "+ex.toString());}
  }

  Future<List<Product>> fetchProductsByBrand(String urlString) async {
    try {
      List<Product> products = [];
      var url = Uri.parse(urlString);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => products.add(Product.fromJson(product)))
            .toList();
        return products;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<List<Product>> fetchRelatedProducts(String productId) async {
    try {
      List<Product> relatedProducts = [];
      var url = Uri.parse(productUrl + "products/related/" + productId);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => relatedProducts.add(Product.fromJson(product)))
            .toList();

        return relatedProducts;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<List<Product>> fetchClassifiedAds() async {
    try {
      List<Product> classifiedProducts = [];
      var url = Uri.parse(baseUrl + "/products/classified");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => classifiedProducts.add(Product.fromJson(product)))
            .toList();
        return classifiedProducts;
      }
    } catch(ex){showSnackBar(context,"clasifeid ads "+ex.toString());}
  }

  Future<List<Product>> fetchReviews(String urlString) async {
    try {
      List<Product> relatedProducts = [];
      var url = Uri.parse(urlString);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data["data"]
            .map((product) => relatedProducts.add(Product.fromJson(product)))
            .toList();

        return relatedProducts;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<Product> getProductDetails(int productId,[int userId]) async {
    try {
      var url = Uri.parse(productUrl + "products/$productId/$userId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var product = data["data"][0];
        return Product.fromJson(product);
      }
    } catch(ex){showSnackBar(context,"Products DEtails "+ex.toString());}
  }

  Future<Product> getProductDetailsByUrl(String link,[int userId]) async {
    try {
      var url = Uri.parse(link+"/$userId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var product = data["data"][0];
        return Product.fromJson(product);
      }
    } catch (ex) {
      print("get Product Detail by url"+ex.toString());
    }
  }

  Future<List<ItemInWishList>> getWishList(String UserId) async {
    List<ItemInWishList> products = [];
    try {
      var customHeaders = {
        'Authorization': 'Bearer $accessToken'
        // other headers
      };
      response = await dio.get(baseUrl + "/wishlists/$UserId",
          options: Options(headers: customHeaders));
      response.data["data"].map((product) {
        products.add(ItemInWishList.fromJson(product));
      }).toList();
    } catch (ex) {
      print("get wish list " + ex);
    }
    return products;
  }

  Future<List<ItemInCart>> getCartProducts(userId) async {
    List<ItemInCart> items = [];
    try {
      var customHeaders = {
        'Authorization': 'Bearer $accessToken'
        // other headers
      };
      response = await dio.get(baseUrl + "/carts/$userId",
          options: Options(headers: customHeaders));
      response.data["data"].map((item) {
        items.add(ItemInCart.fromJson(item));
      }).toList();
    } catch (ex) {
      print("get cart list " + ex);
    }
    return items;
  }

  Future removeFromCart(int itemId,String accessToken) async {try{
    var customHeaders = {
      'Authorization': 'Bearer $accessToken'
      // other headers
    };
    response=  await dio.get(baseUrl+"/carts/remove/$itemId",options: Options(headers:customHeaders)
    );
    print(response.data);
  }catch(ex){print("remove item from cart "+ex.toString());}}

  Future<bool> saveToWishList(int userId, productId) async {
    try {
      await dio.post(baseUrl + "/wishlists",
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}),
          data: {'user_id': userId, 'product_id': productId});

      return true;
    } catch (ex) {
      print("save to wishlist " + ex.toString());
    }
  }

  Future<bool> removeFromWishList(int productId) async {
    try {
      response = await dio.delete(baseUrl + "/wishlists/$productId",
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print(response.data);
    } catch (ex) {
      print("remove from wishlist " + ex.toString());
    }
  }

  Future addToCart(int userId, int productId,var variant) async {
    try {
      response = await dio.post(baseUrl + "/carts/add",
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}),
          data: {
            "id": productId,
            "user_id": userId,
            "variant": variant,
            "color": ""
          });

      print(response.data.toString());
    } catch (ex) {
      print("add to caart " + ex.toString());
    }
  }

  Future changeQuantity(int id, int quantity) async {
    try {
      response = await dio.post(baseUrl + "/carts/change-quantity",
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}),
          data: {'id': id, 'quantity': quantity});
      print(response.data.toString());
    } catch (ex) {
      print("change quantity " + ex.toString());
    }
  }

  ad() async {
    /*
    var response = await http.get(
        'http://192.168.1.105:1337/advertisments',

    );
print(response.body.toString());

     */
/*
    Map<String,String> headerspost = {
      'Content-Type':'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };

    var response1 = await http.post(
        'http://192.168.1.105:1337/advertisments',
        headers: headerspost,
        body: jsonEncode({
            "name": "s",
            "sub_category": "cars",
            "type_of_ads": "st",
            "Governorate": "s",
            "city": "str",
            "category": "Vehicles",
            "models": "stg",
            "status": "string",
            "guarantee": "string",
            "manufacturing_year": "string",
            "kilometers": "string",
            "gear": "string",
            "price": 0,
            "subject": "string",
            "description": "string",
            "user_id": "string",
            "user_number": "string"

        })
    );
    Map<String,String> headers1put = {
      'Content-Type':'application/json',
      'Accept': 'application/json'
    };
    var response = await http.put(
        'http://192.168.1.105:1337/advertisments/4',
        headers: headers1put,
        body: jsonEncode({
          "views":["jjjl"]
        }));

    print("dd"+response.body.toString());
  }
  */
  }
}
