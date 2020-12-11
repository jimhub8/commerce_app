import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop_app/config.dart';
import 'package:shop_app/models/cart_request_model.dart';
import 'package:shop_app/models/cart_response_model.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/customer.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/product.dart';

class ApiService {
  Future<bool> createCustomer(CustomerModel model) async {
    // print('**************************************');
    // print(model);
    // print('**************************************');
    var authToken = base64
        .encode(utf8.encode(Config.consumerKey + ":" + Config.consumerSecret));

    bool ret = false;
    // print(authToken);
    try {
      var response = await Dio().post(Config.url + Config.customeUrl,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'Application/json',
          }));

      if (response.statusCode == 201) {
        print('**************************************');
        print('Success');
        print('**************************************');
        ret = true;
      } else {
        print('**************************************');
        print('Error');
        print('**************************************');
      }
    } on DioError catch (e) {
      print('**************************************');
      print(e);
      print('**************************************');
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
      return ret;
    }
  }

  Future<LoginResponseModel> loginCustomer(
      String username, String password) async {
    LoginResponseModel model;
    try {
      var response = await Dio().post(Config.tokenUrl,
          // Config.url + Config.customeUrl,
          data: {
            'username': username,
            'password': password,
          },
          options: new Options(headers: {
            // HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'Application/x-www-form-urencoded',
          }));

      print(response);

      if (response.statusCode == 200) {
        print('**************************************');
        print(response);
        print('**************************************');
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print('**************************************');
      print(e);
      print('**************************************');
      // if (e.response.statusCode == 404) {
      //   ret = false;
      // } else {
      //   ret = false;
      // }
      // return ret;
    }
    return model;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = new List<Category>();
    // print(authToken);
    try {
      String url = Config.url +
          Config.categoryURL +
          "?consumer_key=${Config.consumerKey}&consumer_secret=${Config.consumerSecret}";
      var response = await Dio().get(url,
          options: new Options(headers: {
            HttpHeaders.contentTypeHeader: 'Application/json',
          }));

      print('¬¬¬¬¬¬¬¬¬¬¬¬`');
      print(response);
      print('¬¬¬¬¬¬¬¬¬¬¬¬`');

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e);
    }
    return data;
  }

  Future<List<Product>> getProducts({
    int pageNumber,
    int pageSize,
    String strSearch,
    String tagName,
    String categoryId,
    List<int> productsIds,
    String sortBy,
    String sortOrder,
    String tagId,
  }) async {
    List<Product> data = new List<Product>();
    try {
      String parameter = "";

      if (strSearch != null) {
        parameter += "&search=$strSearch";
      }
      if (pageSize != null) {
        parameter += "&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }
      if (tagName != null) {
        parameter += "&tag=$tagName";
      }
      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }
      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }
      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }

      if (tagId != null) {
        parameter += "&tag=$tagId";
      }

      if (productsIds != null) {
        parameter += "&include=${productsIds.join(",").toString()}";
      }

      String url = Config.url +
          Config.productsURL +
          "?consumer_key=${Config.consumerKey}&consumer_secret=${Config.consumerSecret}${parameter.toString()}";

      print(url);
      var response = await Dio().get(url,
          options: new Options(headers: {
            HttpHeaders.contentTypeHeader: 'Application/json',
          }));

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e);
    }
    return data;
  }

  Future<CartResponseModel> addtoCart(CartRequestModel model) async {
    model.userId = int.parse(Config.userID);
    // inspect(model[]);
    // var _data = (json.encode(model));
    // var data_ = model.toJson();
    print(model);
    // var _data_ = {
    //   "user_id": 6,
    //   "products": [
    //     {"product_id": 2355, "quantity": 1}
    //   ]
    // };

    CartResponseModel responseModel;

    try {
      String url = Config.url + Config.addCartURL;
      // String url = Config.cocart + Config.addCart;
      print(model.toJson());
      // return
      var response = await Dio().post(url,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.contentTypeHeader: 'Application/json',
          }));

      print("******************");
      print('success');
      print(response);
      print('success');
      print("**********************");
      // print(response.data);
      // print("**********************");
      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
        // return getCartItems();
      }
    } on DioError catch (e) {
      print("eeeeeeeeeeeeeeeeeeeeee");
      print(e);
      print("**********************");
    }
    return responseModel;
  }

  Future<CartResponseModel> getCartItems() async {
    CartResponseModel responseModel;
    try {
      String url = Config.cocart + Config.getCart;
      // String url = Config.url +
      //     Config.cartURL +
      //     "?user_id=${Config.userID}consumer_key=${Config.consumerKey}&consumer_secret=${Config.consumerSecret}";
      // print(url);

      print("******************");
      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
      print("**********************");
      var response = await Dio().get(url,
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer ' + Config.token,
            HttpHeaders.contentTypeHeader: 'Application/json',
          }));

      // print("******************");
      // print(response.data);
      // print("**********************");
      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e);
    }
    return responseModel;
  }
}
