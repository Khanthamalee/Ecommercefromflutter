import 'dart:convert';

import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/data/repository/popular_product_repo.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/model/product_models.dart';
import 'package:ecommerce/util/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  //ตัวแปรชนิดคงที่ constant
  final PopularProductRepo popularProductRepo;

  //default construntor
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  //getter method return list เอาไปใช้งาน
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  //getter return bool เอาไปใช้งาน
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  //getter return int เอาไปใช้งาน
  int get quantity => _quantity;

  //จำนวนในรถเข็นเท่ากับที่มีอยู่ในรถเข็นอยู่แล้ว+จำนวนที่เพิ่มไปใหม่
  //เช่น มีในรถเข็น _inCartItems =  3
  //เพิ่มไปใหม่ _quantity = 4
  //จำนวนในรถเข็นล่าสุด inCartItems = 7
  int _inCartItems = 0;
  //getter return int เอาไปใช้งาน
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    //print("response.body out if: ${response.body}");
    if (response.statusCode == 200) {
      /* ในกรณีที่ response.body เป็น map อยู่แล้วใช้แบบนี้ได้
      _popularProductList = [];
      _popularProductList
          .addAll(Goods.fromJson(response.body).product);*/

      _popularProductList = Goods.fromJson(jsonDecode(response.body)).product;

      //แต่ก่อน _isLoaded = false; แต่ถ้าทำ _popularProductList = Goods.fromJson(jsonDecode(response.body)).product; ให้เป็น true
      _isLoaded = true;

      update();
      print("4. _popularProductList : ${_popularProductList} ===");
    } else {
      print('Can not connect api');
    }
  }

  //ถ้า input เป็น true ให้เพิ่ม +1 แต่ false ให้ลด -1
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      //print("isIncrement ${_quantity + 1}");

      _quantity = checkQuantity(_quantity + 1);
      print("number of items $_quantity");
    } else {
      //print("no isIncrement ${_quantity - 1}");
      _quantity = checkQuantity(_quantity - 1);
      print("number of items $_quantity");
    }
    update();
  }

  //ไม่ให้มีค่าติดลบ และสินค้าไม่เกิน 20 ชิ้น
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "สินค้า",
        "ไม่สามารถลดจำนวนได้มากกว่านี้ค่ะ",
        backgroundColor: AppColors.mainColor,
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
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
      return 20;
    } else {
      return quantity;
    }
  }

  //ค่าเริ่มต้นจำนวน = 0
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
    print("the quantity in th cart is ${_inCartItems}");
  }

  void addItem(ProductModel product) {
    _cart.addItems(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id is ${value.id} ,the quantity is ${value.quantity}");
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
