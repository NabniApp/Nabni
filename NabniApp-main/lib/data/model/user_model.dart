
//model for users
class UserModel {
  String? id;
  String? identity;
  String? username;
  String? phone;
  String? email;
  String? date;
  bool? isVerfied = false;
  String? image;
  String? city;
  String? material;
  String? license_number;
  String? commercial_registration_number;
  String? bio;
  String? user_type;
  String? gender;
  dynamic lastRating = 0.0;

  UserModel({
    this.username,
    this.identity,
    this.phone,
    this.email,
    this.date,
    this.isVerfied,
    this.image,
    this.city,
    this.material,
    this.license_number,
    this.commercial_registration_number,
    this.bio,
    this.user_type,
    this.gender,
    this.lastRating = 0.0,
  });

  UserModel.withId({
    this.id,
    this.username,
    this.identity,
    this.phone,
    this.email,
    this.date,
    this.isVerfied,
    this.image,
    this.city,
    this.material,
    this.license_number,
    this.commercial_registration_number,
    this.bio,
    this.user_type,
    this.gender,
    this.lastRating = 0.0,
  });

//convert text to map to be stored
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['username'] = username;
    map['identity'] = identity;
    map['phone'] = phone;
    map['email'] = email;
    map['date'] = date;
    map['isVerfied'] = isVerfied;
    map['image'] = image;
    map['city'] = city;
    map['material'] = material;
    map['license_number'] = license_number;
    map['commercial_registration_number'] = commercial_registration_number;
    map['bio'] = bio;
    map['user_type'] = user_type;
    map['gender'] = gender;
    map['lastRating'] = lastRating;
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.withId(
      id: map['id'],
      username: map['username'],
      identity: map['identity'],
      phone: map['phone'],
      email: map['email'],
      date: map['date'],
      isVerfied: map['isVerfied'],
      image: map['image'],
      city: map['city'],
      material: map['material'],
      license_number: map['license_number'],
      commercial_registration_number: map['commercial_registration_number'],
      bio: map['bio'],
      user_type: map['user_type'],
      gender: map['gender'],
      lastRating: map['lastRating'],
    );
  }
}
