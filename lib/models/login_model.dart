class LoginModel{
  late bool status;
  late String message;
  late UserData data;

  LoginModel.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJSON(json['data']) : null)!;
  }
}

class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;


  UserData.fromJSON(Map<String, dynamic> json){
     id = json['id'];
     name = json['name'];
     phone = json['phone'];
     image = json['image'];
     email = json['email'];
     points = json['points'];
     credit = json['credit'];
     token = json['token'];
  }
}