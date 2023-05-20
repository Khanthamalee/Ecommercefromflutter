import 'dart:convert';

import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/data/repository/popular_product_repo.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/model/product_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems {
    return _inCartItems + _quantity;
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    print("response.body: ${response.body}");
    if (response.statusCode == 200) {
      // ในกรณีที่ response.body เป็น map อยู่แล้วใช้แบบนี้ได้
      _popularProductList = [];
      _popularProductList.addAll(Goods.fromJson(response.body).product);

      /* _popularProductList = Goods.fromJson(jsonDecode(response.body)).product;*/

      _isLoaded = true;

      update();
    } else {
      print('Can not connect api');
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "สินค้า",
        "ไม่สามารถลดจำนวนได้มากกว่านี้ค่ะ",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;

        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "สินค้า",
        "ไม่สามารถเพิ่มจำนวนได้มากกว่า 20 ชิ้นค่ะ",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );

      return _quantity;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    print("exist or not ${exist}");
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItems(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {});

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
