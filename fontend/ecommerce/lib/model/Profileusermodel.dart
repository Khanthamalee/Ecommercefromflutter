class ProfileuserModel {
  User? user;
  String? phone;
  Homeaddress? homeaddress;
  Officeaddress? officeaddress;
  Presentpositionaddress? presentpositionaddress;
  int? orderCount;
  int? typeId;

  ProfileuserModel(
      {this.user,
      this.phone,
      this.homeaddress,
      this.officeaddress,
      this.presentpositionaddress,
      this.orderCount,
      this.typeId});

  ProfileuserModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    phone = json['phone'];
    homeaddress = json['homeaddress'] != null
        ? Homeaddress.fromJson(json['homeaddress'])
        : null;
    officeaddress = json['officeaddress'] != null
        ? Officeaddress.fromJson(json['officeaddress'])
        : null;
    presentpositionaddress = json['presentpositionaddress'] != null
        ? Presentpositionaddress.fromJson(json['presentpositionaddress'])
        : null;
    orderCount = json['order_count'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['phone'] = this.phone;
    if (this.homeaddress != null) {
      data['homeaddress'] = this.homeaddress!.toJson();
    }
    if (this.officeaddress != null) {
      data['officeaddress'] = this.officeaddress!.toJson();
    }
    if (this.presentpositionaddress != null) {
      data['presentpositionaddress'] = this.presentpositionaddress!.toJson();
    }
    data['order_count'] = this.orderCount;
    data['type_id'] = this.typeId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  double? latitude;
  double? longitude;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  double? latitude;
  double? longitude;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  double? latitude;
  double? longitude;
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
