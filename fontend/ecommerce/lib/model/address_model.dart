class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonalName;
  late String _contactPersonalNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel(
      {id,
      required addressType,
      contactPersonalName,
      contactPersonalNumber,
      address,
      latitude,
      longitude}) {
    _id = id;
    _addressType = addressType;
    _contactPersonalName = contactPersonalName;
    _contactPersonalNumber = contactPersonalNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonalName => _contactPersonalName;
  String? get contactPersonalNumber => _contactPersonalNumber;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? "";
    _contactPersonalName = json["contact_personal_name"] ?? "";
    _contactPersonalNumber = json['cotact_personal_number'] ?? "";
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this._id;
    data['addressType'] = this._addressType;
    data['contactPersonalName'] = this._contactPersonalName;
    data['contactPersonalNumber'] = this._contactPersonalNumber;
    data['address'] = this._address;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;

    return data;
  }
}
