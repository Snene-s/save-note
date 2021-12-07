class Member {
  final String? username;
  final String email;
  final String? phone;
  final String? color;
  const Member({this.username, required this.email, this.phone, this.color});

  factory Member.fromJson(Map<String, dynamic> json) => Member(
      username: json["name"],
      email: json["email"],
      phone: json["phone"].toString(),
      color: json["color"].toString());

  factory Member.fromString(String json) => Member(username: json, email: json);
}
