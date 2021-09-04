import 'dart:math' as math;

class Member {
  final String name;
  final String email;
  final String phone;
  final int color;
  const Member(
      {required this.name,
      required this.email,
      required this.phone,
      required this.color});
  factory Member.fromJson(Map<String, dynamic> json,int color) =>
      Member(name: json["name"], email: json["email"], phone: json["phone"],color:color);

  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "phone": phone};
}
