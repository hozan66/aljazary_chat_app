class SignUpModel {
  late String status;
  late SignUpDataModel data;

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SignUpDataModel.fromJson(json['data']);
  }
}

class SignUpDataModel {
  late String accessToken;

  SignUpDataModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }
}
