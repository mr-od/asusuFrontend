class UserModel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final int phone;
  final String aboutVendor;
  final String location;

  UserModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.aboutVendor,
    required this.location,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      location: json['location'],
      aboutVendor: json['about_vendor'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username, //1
        'first_name': firstName, //3
        'last_name': lastName, //4
        'email': email, //5
        'about': aboutVendor, //7
        'location': location, //8
        'phone': phone, //8
      };

  static List<UserModel> listFromJson(List<dynamic> list) =>
      List<UserModel>.from(list.map((x) => UserModel.fromJson(x)));
}

class SingleUserModel {
  final String username;
  final String email;
  final int id;

  SingleUserModel({
    required this.username,
    required this.email,
    required this.id,
  });

  factory SingleUserModel.fromJson(Map<String, dynamic> json) {
    return SingleUserModel(
      username: json['username'],
      email: json['email'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username, //1
        'email': email, //5
        'id': id, //5
      };

  static List<SingleUserModel> listFromJson(List<dynamic> list) =>
      List<SingleUserModel>.from(list.map((x) => UserModel.fromJson(x)));
}

class UserRegisterModel {
  String? username;
  String? email;
  UserModel? password;

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }
}
