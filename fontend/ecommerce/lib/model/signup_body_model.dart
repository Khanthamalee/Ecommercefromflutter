class SignUpBody {
  String firstname;
  String lastname;
  String username;
  String email;
  String password;
  String confirmpassword;
  SignUpBody(
      {required this.firstname,
      required this.lastname,
      required this.username,
      required this.email,
      required this.password,
      required this.confirmpassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstname;
    data['last_name'] = this.lastname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password2'] = this.confirmpassword;
    return data;
  }
}
