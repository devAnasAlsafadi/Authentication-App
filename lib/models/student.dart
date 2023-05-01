class Student {
  late int id;
  late String fullName;
  late String email;
  late  String gender;
  late  String? verificationCode;
  late  String? fcmToken;
  late String token;
  late  String refreshToken;
  late bool isActive;
  late String password;


  Student();

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    verificationCode = json['verification_code'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    refreshToken = json['refresh_token'];
    isActive = json['is_active'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['full_name'] = this.fullName;
  //   data['email'] = this.email;
  //   data['gender'] = this.gender;
  //   data['verification_code'] = this.verificationCode;
  //   data['fcm_token'] = this.fcmToken;
  //   data['token'] = this.token;
  //   data['refresh_token'] = this.refreshToken;
  //   data['is_active'] = this.isActive;
  //   return data;
  // }
}