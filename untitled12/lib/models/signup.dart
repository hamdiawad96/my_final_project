class SignupModel {

  String type;
  String token;

  SignupModel
  (this.type, this.token);


  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel
        (json['type'], json['token']);

  }
}

//
// Map<String, dynamic> toJson() {
//   return {
//     'firstName': firstName,
//     'lastName': lastName,
//     'city': city,
//     'country': country,
//     'phone': phone,
//     'username': username,
//     'email': email,
//     'password': password,
//   };
// }