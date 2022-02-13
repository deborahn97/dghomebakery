class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? otp;
  String? status;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.otp,
    required this.status,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    otp = json['otp'];
    status = json['status'];
  }
}
