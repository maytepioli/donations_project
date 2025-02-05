
class User {
  User({
    required this.uuid, 
    required this.name, 
    required this.password, 
    required this.email, 
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'] as String? ?? '', 
      name: json['name'] as String? ?? '', 
      password: json['password'] as String? ?? '', 
      email: json['email'] as String? ?? '', 
      phoneNumber: json['phoneNumber'] as int? ?? 0,
      );
  }

  final String uuid;
  final String name;
  final String password;
  final String email;
  int phoneNumber;
  
  int changePhoneNumber(int newPhoneNumber) => phoneNumber = newPhoneNumber;


}
