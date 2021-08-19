class Member {
  final String name;
  final String email;
  final String phone;

  const Member(
      {required this.name,
      required this.email,
      required this.phone,
      String? imgUrl});
  factory Member.fromJson(Map<String, dynamic> json) =>
      Member(name: json["name"], email: json["email"], phone: json["phone"]);
  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "phone": phone};
}
