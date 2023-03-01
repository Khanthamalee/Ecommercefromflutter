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
    if (response.statusCode == 200) {
      //print("3. class PopularProductController _popularProductList : ${_popularProductList} ===");
      //Build Model Nested Json
      _popularProductList = [];
      // response.body เป็น dictionary
      _popularProductList.addAll(Goods.fromJson(response.body).product);
      //แต่ก่อน _isLoaded = fault; แต่ถ้าทำ _popularProductList.addAll ให้เป็น true
      _isLoaded = true;
      //print("response.body: ${response.body}");

      update();
      //print("4. class PopularProductController  _popularProductList : ${_popularProductList} ===");
    } else {}
  }

  ///response.body : {total_size: 6, type_id: 2, offset: 0, products: [{id: 1, name: Nutritious fruit meal in china, description: This five red bases, two are dedicated to salami (fennel and regular), and there s a classic capricciosa or beef carpaccio. Blanco options include a mushroom, and a four-cheese extravaganza featuring great lobes of a tangy fior di latte they make in house every day (more on this later). Classic, precise, good.I think it s still better to think of this venue not as a pizzeria, but as Pizza, by Di Stasio.Rinaldo Di Stasio and Mallory Wall s empire, including the original restaurant and bar in St Kilda, Citta and now Carlton, is a designer label for dining., price: 12, stars: 4, img: images/ea9367e8a16f1d3e41d4a3ae9af2baff.png, location: Canada, British Columbia, created_at: 2021-11-17 10:09:08, updated_at: 2022-05-16 11:48:53, type_id: 2}, {id: 2, name: Sweet Dessert, description: The best sweet dessertThe quality and craftsmanship is on full show. The waiters  signature white tunics are///

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
        "Item count",
        "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        //duration: Duration(seconds: 1),
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        //duration: Duration(seconds: 1),
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
