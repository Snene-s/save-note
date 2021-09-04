import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:savenote/models/user.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;
  User user = User(
      id: 0,
      name: "Mehdi",
      email: "mehdi@gmail.com",
      imgUrl:
          "https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half-caption/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=0hb44OrI");

  getUser() {
      return user;
  }
}
