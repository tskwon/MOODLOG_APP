class UserModel {
  final String email;
  final String password;
  final String name;
  //final String phone;
  //final String gender;
  //final String age;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    //required this.phone,
    //required this.gender,
    //required this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
