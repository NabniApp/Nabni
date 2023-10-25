class SuplierModel {
  String? suplierId;
  String? suplierName;
  String? suplierEmail;
  String? suplierMobile;
  String? suplierPassword;
  String? suplierCity;
  String? suplierPhoto;
  String? suplierLicense;
  String? suplierType;
  String? suplierComNumber;
  String? suplierPio;

  SuplierModel(
      {this.suplierId,
      this.suplierName,
      this.suplierEmail,
      this.suplierMobile,
      this.suplierPassword,
      this.suplierCity,
      this.suplierPhoto,
      this.suplierLicense,
      this.suplierType,
      this.suplierComNumber,
      this.suplierPio});

  SuplierModel.fromJson(Map<String, dynamic> json) {
    suplierId = json['suplier_id'];
    suplierName = json['suplier_name'];
    suplierEmail = json['suplier_email'];
    suplierMobile = json['suplier_mobile'];
    suplierPassword = json['suplier_password'];
    suplierCity = json['suplier_city'];
    suplierPhoto = json['suplier_photo'];
    suplierLicense = json['suplier_license'];
    suplierType = json['suplier_type'];
    suplierComNumber = json['suplier_com_number'];
    suplierPio = json['suplier_pio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suplier_id'] = this.suplierId;
    data['suplier_name'] = this.suplierName;
    data['suplier_email'] = this.suplierEmail;
    data['suplier_mobile'] = this.suplierMobile;
    data['suplier_password'] = this.suplierPassword;
    data['suplier_city'] = this.suplierCity;
    data['suplier_photo'] = this.suplierPhoto;
    data['suplier_license'] = this.suplierLicense;
    data['suplier_type'] = this.suplierType;
    data['suplier_com_number'] = this.suplierComNumber;
    data['suplier_pio'] = this.suplierPio;
    return data;
  }
}
