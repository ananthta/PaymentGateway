class AddressDto {
  String address1;
  String address2;
  String city;
  String state;
  String zipcode;
  String deliveryMethod;

  AddressDto(
      {this.address1,
      this.address2,
      this.city,
      this.state,
      this.zipcode,
      this.deliveryMethod});

  AddressDto.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    deliveryMethod = json['deliveryMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    data['deliveryMethod'] = this.deliveryMethod;
    return data;
  }

  void SetFromPickerAddress(locationPickerAddress) {
    address1 = locationPickerAddress['line0'];
    address2 = locationPickerAddress['line1'] == "" ? address1 : "";
    city = locationPickerAddress['locality'];
    zipcode = locationPickerAddress['postalCode'];
    state = locationPickerAddress['administrativeArea'];
    deliveryMethod = "Delivery"; //TODO: remove default value
  }
}
