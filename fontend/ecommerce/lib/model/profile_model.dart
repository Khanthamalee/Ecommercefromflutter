class ProfileModel {
  Map<String, dynamic>? _user;
  String? _phone;
  Map<String, dynamic>? _homeaddress;
  Map<String, dynamic>? _officeaddress;
  Map<String, dynamic>? _presentpositionaddress;
  int? _orderCount;
  int? _typeId;

  ProfileModel(
      {required user,
      required phone,
      required homeaddress,
      required officeaddress,
      required presentpositionaddress,
      required orderCount,
      typeId}) {
    _user = user;
    _phone = phone;
    _homeaddress = homeaddress;
    _officeaddress = officeaddress;
    _presentpositionaddress = presentpositionaddress;
    _orderCount = orderCount;
    _typeId = typeId;
  }
  Map<String, dynamic>? get user => _user;
  String? get phone => _phone;
  Map<String, dynamic>? get homeaddress => _homeaddress;
  Map<String, dynamic>? get officeaddress => _officeaddress;
  Map<String, dynamic>? get presentpositionaddress => _presentpositionaddress;
  int? get orderCount => _orderCount;
  int? get typeId => _typeId;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    _user = (json['user'] != null ? User.fromJson(json['user']) : null)
        as Map<String, dynamic>?;
    _phone = json['phone'];
    _homeaddress = (json['homeaddress'] != null
        ? Homeaddress.fromJson(json['homeaddress'])
        : null) as Map<String, dynamic>?;
    _officeaddress = (json['officeaddress'] != null
        ? Officeaddress.fromJson(json['officeaddress'])
        : null) as Map<String, dynamic>?;
    _presentpositionaddress = (json['presentpositionaddress'] != null
        ? Presentpositionaddress.fromJson(json['presentpositionaddress'])
        : null) as Map<String, dynamic>?;
    _orderCount = json['order_count'];
    _typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user!;
    }
    data['phone'] = this._phone;
    if (this._homeaddress != null) {
      data['homeaddress'] = this._homeaddress!;
    }
    if (this._officeaddress != null) {
      data['officeaddress'] = this._officeaddress!;
    }
    if (this._presentpositionaddress != null) {
      data['presentpositionaddress'] = this._presentpositionaddress!;
    }
    data['order_count'] = this._orderCount;
    data['type_id'] = this._typeId;
    return data;
  }
}

class User {
  int? userId;
  String? username;
  String? firstname;
  String? lastname;
  String? email;

  User({this.userId, this.username, this.firstname, this.lastname, this.email});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    return data;
  }
}

class Homeaddress {
  int? homeaddressId;
  String? latitude;
  String? longitude;
  String? addressname;
  String? address;
  String? tombon;
  String? amphure;
  String? province;
  String? city;
  String? zipCode;
  int? typeId;

  Homeaddress(
      {this.homeaddressId,
      this.latitude,
      this.longitude,
      this.addressname,
      this.address,
      this.tombon,
      this.amphure,
      this.province,
      this.city,
      this.zipCode,
      this.typeId});

  Homeaddress.fromJson(Map<String, dynamic> json) {
    homeaddressId = json['homeaddress_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressname = json['addressname'];
    address = json['address'];
    tombon = json['tombon'];
    amphure = json['amphure'];
    province = json['province'];
    city = json['city'];
    zipCode = json['zip_code'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['homeaddress_id'] = this.homeaddressId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['addressname'] = this.addressname;
    data['address'] = this.address;
    data['tombon'] = this.tombon;
    data['amphure'] = this.amphure;
    data['province'] = this.province;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['type_id'] = this.typeId;
    return data;
  }
}

class Officeaddress {
  int? officeaddressId;
  String? latitude;
  String? longitude;
  String? addressname;
  String? address;
  String? tombon;
  String? amphure;
  String? province;
  String? city;
  String? zipCode;
  int? typeId;

  Officeaddress(
      {this.officeaddressId,
      this.latitude,
      this.longitude,
      this.addressname,
      this.address,
      this.tombon,
      this.amphure,
      this.province,
      this.city,
      this.zipCode,
      this.typeId});

  Officeaddress.fromJson(Map<String, dynamic> json) {
    officeaddressId = json['officeaddress_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressname = json['addressname'];
    address = json['address'];
    tombon = json['tombon'];
    amphure = json['amphure'];
    province = json['province'];
    city = json['city'];
    zipCode = json['zip_code'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['officeaddress_id'] = this.officeaddressId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['addressname'] = this.addressname;
    data['address'] = this.address;
    data['tombon'] = this.tombon;
    data['amphure'] = this.amphure;
    data['province'] = this.province;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['type_id'] = this.typeId;
    return data;
  }
}

class Presentpositionaddress {
  int? presentpositionaddressId;
  String? latitude;
  String? longitude;
  String? addressname;
  String? address;
  String? tombon;
  String? amphure;
  String? province;
  String? city;
  String? zipCode;
  int? typeId;

  Presentpositionaddress(
      {this.presentpositionaddressId,
      this.latitude,
      this.longitude,
      this.addressname,
      this.address,
      this.tombon,
      this.amphure,
      this.province,
      this.city,
      this.zipCode,
      this.typeId});

  Presentpositionaddress.fromJson(Map<String, dynamic> json) {
    presentpositionaddressId = json['presentpositionaddress_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressname = json['addressname'];
    address = json['address'];
    tombon = json['tombon'];
    amphure = json['amphure'];
    province = json['province'];
    city = json['city'];
    zipCode = json['zip_code'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['presentpositionaddress_id'] = this.presentpositionaddressId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['addressname'] = this.addressname;
    data['address'] = this.address;
    data['tombon'] = this.tombon;
    data['amphure'] = this.amphure;
    data['province'] = this.province;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['type_id'] = this.typeId;
    return data;
  }
}
