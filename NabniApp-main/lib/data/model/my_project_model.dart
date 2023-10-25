
class MyProjectModel {
  String? id;
  String? description;
  String? name;
  String? price;
  String? space;
  List? images;

  MyProjectModel({
    this.description,
    this.name,
    this.price,
    this.space,
    this.images,
  });

  MyProjectModel.withId({
    this.id,
    this.description,
    this.name,
    this.price,
    this.space,
    this.images,
  });

//convert text to map to be stored
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['description'] = description;
    map['name'] = name;
    map['price'] = price;
    map['space'] = space;
    map['images'] = images;
    return map;
  }

  factory MyProjectModel.fromMap(Map<String, dynamic> map) {
    return MyProjectModel.withId(
      id: map['id'],
      description: map['description'],
      price: map['price'],
      space: map['space'],
      name: map['name'],
      images: map['images'],
    );
  }
}
