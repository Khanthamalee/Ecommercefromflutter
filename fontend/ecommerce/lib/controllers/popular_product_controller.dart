import 'package:ecommerce/data/repository/popular_product_repo.dart';
import 'package:ecommerce/model/product_models.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got Products");
      //Build Model Nested Json
      _popularProductList = [];
      _popularProductList.addAll(Goods.fromJson(response.body).product);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }
}
