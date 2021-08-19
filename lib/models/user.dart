class User {
  int id;
  String name;
  String email;
  String imgUrl;

  User({required this.id,required this.name, required this.email,required this.imgUrl});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      id: responseData['id'] ,
      name: responseData["name"],
      imgUrl: responseData['imgUrl'],
      email: responseData['email']?? "Not found",

    );
  }
}