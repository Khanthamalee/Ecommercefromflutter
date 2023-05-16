class Profileuser {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get product => _products;

  Profileuser(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  Profileuser.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  User? user;
  String? phone;
  Address? address;
  int? orderCount;
  int? typeId;

  ProductModel(
      {this.user, this.phone, this.address, this.orderCount, this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    phone = json['phone'];
    if (json['address'] != null) {
      address = Address.fromJson(json['address']);
    }
    orderCount = json['order_count'];
    typeId = json['type_id'];
  }
}

class User {
  String? username;
  String? firstname;
  String? lastname;
  String? email;

  User({this.username, this.firstname, this.lastname, this.email});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }
}

class Address {
  String? address;
  String? tombon;
  String? amphure;
  String? province;
  String? city;
  String? zipCode;
  int? typeId;

  Address(
      {this.address,
      this.tombon,
      this.amphure,
      this.province,
      this.city,
      this.zipCode,
      this.typeId});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    tombon = json['tombon'];
    amphure = json['amphure'];
    province = json['province'];
    city = json['city'];
    zipCode = json['zip_code'];
    typeId = json['type_id'];
  }
}
