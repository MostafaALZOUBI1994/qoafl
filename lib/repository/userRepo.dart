import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qawafel/constants.dart';
import 'package:qawafel/models/address.dart';
import 'package:qawafel/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/widgets/snakbar.dart';

class UserRepo {
  Response response;
  var dio = Dio();
  final BuildContext context;
  User user;
  UserRepo(this.context);
  Future<User> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      user = User(accessToken: prefs.get("token"), userId: prefs.get("userId"));
      //await getUserProfile(user.accessToken, user.userId);
      return user;
    } catch (ex) {
      print("getUser " + ex.toString());
    }
  }

  Future<User> getUserProfile(String accessToken, int userId) async {
    try {
      var customHeaders = {
        'Authorization': 'Bearer $accessToken'
        // other headers
      };
      response = await dio.get(baseUrl + "/user/info/$userId",
          options: Options(headers: customHeaders));

      UserInfo userInfo = UserInfo.fromJson(response.data["data"][0]);
      kUser =
          User(accessToken: accessToken, userId: userId, userInfo: userInfo);

      return kUser;
    } catch (ex) {
      print("getUserProfile " + ex.toString());
    }
  }

  Future saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kUser = user;
    prefs.setInt("userId", user.userInfo.id);
    prefs.setString("token", user.accessToken);
  }

  Future signIn(String email, String password) async {
    try {
      response = await dio.post(baseUrl + "/auth/login",
          data: {'email': email, 'password': password, "remember_me": true});
      if (response.statusCode == 200) {
        user = User.fromJson(response.data);
        saveUser(user);
      }
    } catch (ex) {
      showSnackBar(context, "SignIn Failed");
    }
  }

  Future signUp(String userName, String email, String password,
      String confirmPassword) async {
    try {
      response = await dio.post(baseUrl + "/auth/signup", data: {
        "name": userName,
        'email': email,
        'password': password,
        "passowrd_confirmation": confirmPassword
      });
      if (response.statusCode == 200) {
        showSnackBar(context, "SignUp Success Please SignIn");
        return true;
      }
      return true;
    } catch (ex) {
      showSnackBar(context, "SignUp Failed");
    }
  }

  Future<bool> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("userId");
      prefs.remove("token");
      kUser.userId = null;
      kUser.accessToken = null;
      showSnackBar(context, "Sign Out successfully");
      return true;
    } catch (ex) {
      showSnackBar(context, "Sign Out Failed");
    }
  }

  Future<List<AddressModel>> getAddress(int userId, String accessToken) async {
    List<AddressModel> allAddresses = [];
    var customHeaders = {
      'Authorization': 'Bearer $accessToken'
      // other headers
    };
    response = await dio.get(baseUrl + "/user/shipping/address/$userId",
        options: Options(headers: customHeaders));
    if (response.statusCode == 200) {
      response.data["data"]
          .map((address) => allAddresses.add(AddressModel.fromJson(address)))
          .toList();
    }

    return allAddresses;
  }

  Future addAddress(int userId, String accessToken, String address,
      String country, String city, String postalCode, String phone) async {
    var customHeaders = {
      'Authorization': 'Bearer $accessToken'
      // other headers
    };
    var response = await dio.post(baseUrl + '/user/shipping/create',
        data: {
          "user_id": userId,
          "address": address,
          "country": country,
          "city": city,
          "postal_code": postalCode,
          "phone": phone
        },
        options: Options(
            method: 'POST',
            headers: customHeaders,
            responseType: ResponseType.json // or ResponseType.JSON
            ));
    print(response.data);
  }

  Future removeAddresss(int addressId,String accessToken) async {try{
    var customHeaders = {
      'Authorization': 'Bearer $accessToken'
      // other headers
    };
     response=  await dio.get(baseUrl+"/user/shipping/delete/$addressId",options: Options(headers:customHeaders)
     );
print(response.data);
  }catch(ex){print("remove addres "+ex.toString());}}
  
  Future<String> inVoice(int userId) async {
    try {
      response = await dio.get(baseUrl + "/payments/invoice/$userId");
      if (response.statusCode == 200) {
        return response.data["url"];
      } else {}
    } catch (ex) {
      print("inVoice  " + ex.toString());
    }
  }
}
