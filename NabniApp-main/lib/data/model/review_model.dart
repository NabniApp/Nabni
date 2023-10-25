
class ReviewModel {
  String? id;
  String? content;
  double? stars;
  String? client_id;
  String? client_name;
  

  ReviewModel({
    this.content,
    this.stars,
    this.client_id,
    this.client_name,
  });

  ReviewModel.withId({
    this.id,
    this.content,
    this.stars,
    this.client_id,
    this.client_name,
  });

//convert text to map to be stored
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['content'] = content;
    map['stars'] = stars;
    map['client_id'] = client_id;
    map['client_name'] = client_name;
    return map;
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel.withId(
      id: map['id'],
      stars: map['stars'],
      content: map['content'],
      client_id: map['client_id'],
      client_name: map['client_name'],
    );
  }
}
