class SignUpBody {
  String name;
  String phone;
  String email;
  String password;

  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = {
    //   'name': name,
    //   'phone': phone,
    //   'email': email,
    //   'password': password,
    // };
    final Map<String, dynamic> data = {};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
