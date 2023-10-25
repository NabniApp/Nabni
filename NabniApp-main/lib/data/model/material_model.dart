class MaterialModel {
  String? id;
  String? username;
  dynamic quantity;
  dynamic price;
  String? date;
  String? image;
  String? subject_type;
  String? supplier_unit;
  String? contractor_id;
  String? client_id;
  String? project_id;
  bool? isAcceptedBySupplier;
  String? created_by;

  MaterialModel({
    this.username,
    this.quantity,
    this.price,
    this.date,
    this.image,
    this.subject_type,
    this.supplier_unit,
    this.contractor_id,
    this.client_id,
    this.project_id,
    this.isAcceptedBySupplier = false,
    this.created_by,
  });

  MaterialModel.withId({
    this.id,
    this.username,
    this.quantity,
    this.price,
    this.date,
    this.image,
    this.subject_type,
    this.supplier_unit,
    this.contractor_id,
    this.client_id,
    this.project_id,
    this.isAcceptedBySupplier,
    this.created_by,
  });

//convert text to map to be stored
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['username'] = username;
    map['quantity'] = quantity;
    map['price'] = price;
    map['date'] = date;
    map['image'] = image;
    map['subject_type'] = subject_type;
    map['supplier_unit'] = supplier_unit;
    map['contractor_id'] = contractor_id;
    map['client_id'] = client_id;
    map['project_id'] = project_id;
    map['isAcceptedBySupplier'] = isAcceptedBySupplier;
    map['created_by'] = created_by;
    return map;
  }

  factory MaterialModel.fromMap(Map<String, dynamic> map) {
    return MaterialModel.withId(
      id: map['id'],
      username: map['username'],
      quantity: map['quantity'],
      price: map['price'],
      date: map['date'],
      image: map['image'],
      subject_type: map['subject_type'],
      supplier_unit: map['supplier_unit'],
      contractor_id: map['contractor_id'],
      client_id: map['client_id'],
      project_id: map['project_id'],
      isAcceptedBySupplier: map['isAcceptedBySupplier'],
      created_by: map['created_by'],
    );
  }
}
