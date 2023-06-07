class User {
  String? name;
  String? email;
  String? password;
  String? location;
  int? phone_number;

  User(
      {this.name, this.email, this.password, this.location, this.phone_number});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      location: json['location'],
      phone_number: json['phone_number'],
    );
  }
}
