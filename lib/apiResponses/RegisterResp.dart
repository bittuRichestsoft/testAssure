class RegisterResp {
  String message;
  bool status;
  List<Data> data;

  RegisterResp({this.message, this.status, this.data});




  RegisterResp.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data .add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  /*{"message":"Otp Send
Successful","status":true,"data":[{
"id":"9",
"us_phone":"2222202233",
"otp_code":"223845",
"otp_verify":"0",
"devicetype":"android",
"token":"egeghhghhh567","version":"1.5","created_on":"dsf"}]}*/
  String id;
  String us_phone;
  String otp_code;
  String otp_verify;
  String devicetype;
  String token;
   String version;

  Data(
      {this.id,
         this.us_phone,
         this.otp_code,
         this.otp_verify,
        this.devicetype,
         this.token,
         this.version
 });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    us_phone = json['us_phone'];
    otp_code= json['otp_code'];
    otp_verify= json['otp_verify'];
     devicetype = json['devicetype'];
    token = json['token'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
     data['us_phone'] = this.us_phone;
    data['otp_code'] = this.otp_code;
    data['otp_verify'] = this.otp_verify;
    data['devicetype'] = this.devicetype;
     data['token'] = this.token;
    data['version'] = this.version;
     return data;
  }
}