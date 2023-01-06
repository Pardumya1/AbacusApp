

class LoginModel {

  final String status;
  final String message;
  final String? token;

  factory LoginModel.fromJson(Map<String, dynamic> json) {

    return LoginModel(

      status: json['status'],
      message: json['message'],
      token: json['token'],

    );

  }
  LoginModel({required this.status, required this.message, this.token});


}
