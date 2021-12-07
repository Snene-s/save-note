class User {
  String username;
  String email;
  String color;
  int phone;
  String ?admin;

  User({ required this.username, required this.email,required this.color,required this.phone,this.admin});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      username: responseData["username"],
      email: responseData['email'],
      color: responseData['color'],
      phone: responseData['phone'] ,
      admin: responseData['admin_of'],
    );
  }
}