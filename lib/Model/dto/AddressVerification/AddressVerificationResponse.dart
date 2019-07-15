class AddressVerificationResponse {
  bool verification;
  String distance;
  String remark;
  String errorField;

  AddressVerificationResponse(
      {this.verification, this.distance, this.remark, this.errorField});

  AddressVerificationResponse fromJson(Map<String, dynamic> json) {
    return new AddressVerificationResponse(
        distance: json['distance'],
        errorField: json['errorField'],
        remark: json['remark'],
        verification: json['verification']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verification'] = this.verification;
    data['distance'] = this.distance;
    data['remark'] = this.remark;
    data['errorField'] = this.errorField;
    return data;
  }
}
