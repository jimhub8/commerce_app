import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/api/api_service.dart';
import 'package:shop_app/models/cart_request_model.dart';
import 'package:shop_app/models/cart_response_model.dart';

class CartProvider with ChangeNotifier {
  ApiService _apiService;
  List<CartItem> _cartItems;
  List<CartItem> get CartItems => _cartItems;

  double get totalRecords => _cartItems.length.toDouble();

  CartProvider() {
    _apiService = new ApiService();
    _cartItems = new List<CartItem>();
  }

  void resetStream() {
    _apiService = new ApiService();
    _cartItems = new List<CartItem>();
  }

  void addToCart(CartProducts product, Function onCallback) async {
    CartRequestModel requestModel = new CartRequestModel();
    requestModel.products = new List<CartProducts>();

    if (_cartItems == null) resetStream();

    _cartItems.forEach((element) {
      requestModel.products.add(new CartProducts(
          productId: element.productId, quantity: element.qty));
    });
    var isProductExist = requestModel.products.firstWhere(
        (prd) => prd.productId == product.productId,
        orElse: () => null);

    if (isProductExist != null) {
      requestModel.products.remove(isProductExist);
    }
    requestModel.products.add(isProductExist);

    await _apiService.addtoCart(requestModel).then((cartResponseModel) {
      // print('¬¬¬¬¬¬¬¬¬¬¬¬¬333333333¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬');
      // print(json.encode(cartRequestModel));
      // print('¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬');
      if (cartResponseModel != null) {
        _cartItems = [];
        _cartItems.addAll(cartResponseModel.data);
      }
      onCallback(cartResponseModel);
      notifyListeners();
    });
  }
}
