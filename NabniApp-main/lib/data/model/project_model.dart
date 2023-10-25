import 'package:new_nabni_app/data/model/material_model.dart';

class ProjectModel {
  String? id;
  String? description;
  String? price;
  double? lat;
  double? lng;
  String? date;
  String? imageIdentity;
  String? imageLicence;
  String? imageMap;
  String? client_id;
  String? client_name;
  String? contractor_id;
  String? contractor_name;
  String? status;
  String? height;
  String? width;
  String? totalPriceOfMaterials;
  bool? isReviewAndEnd;
  bool materialSelected = false;
  List? materials;

  ProjectModel({
    this.description,
    this.price,
    this.lat,
    this.lng,
    this.date,
    this.imageIdentity,
    this.imageLicence,
    this.imageMap,
    this.client_id,
    this.client_name,
    this.contractor_id,
    this.contractor_name,
    this.status,
    this.height,
    this.width,
    this.totalPriceOfMaterials,
    this.isReviewAndEnd,
    this.materialSelected = false,
    this.materials,
  });

  ProjectModel.withId({
    this.id,
    this.description,
    this.price,
    this.lat,
    this.lng,
    this.date,
    this.imageIdentity,
    this.imageLicence,
    this.imageMap,
    this.client_id,
    this.client_name,
    this.contractor_id,
    this.contractor_name,
    this.status,
    this.height,
    this.width,
    this.totalPriceOfMaterials,
    this.isReviewAndEnd,
    this.materialSelected = false,
    this.materials,
  });

  // Convert ProjectModel to a map for storage
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['description'] = description;
    map['price'] = price;
    map['lat'] = lat;
    map['lng'] = lng;
    map['date'] = date;
    map['imageIdentity'] = imageIdentity;
    map['imageLicence'] = imageLicence;
    map['imageMap'] = imageMap;
    map['client_id'] = client_id;
    map['client_name'] = client_name;
    map['contractor_id'] = contractor_id;
    map['contractor_name'] = contractor_name;
    map['status'] = status;
    map['height'] = height;
    map['width'] = width;
    map['totalPriceOfMaterials'] = totalPriceOfMaterials;
    map['isReviewAndEnd'] = isReviewAndEnd;
    map['materialSelected'] = materialSelected;

    // Convert the materials list to a list of maps
    if (materials != null) {
      map['materials'] =
          materials!.map((material) => material.toMap()).toList();
    } else {
      map['materials'] = null;
    }

    return map;
  }

  // Create a ProjectModel from a map
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel.withId(
      id: map['id'],
      description: map['description'],
      lat: map['lat'],
      price: map['price'],
      lng: map['lng'],
      date: map['date'],
      imageIdentity: map['imageIdentity'],
      imageLicence: map['imageLicence'],
      imageMap: map['imageMap'],
      client_id: map['client_id'],
      client_name: map['client_name'],
      contractor_id: map['contractor_id'],
      contractor_name: map['contractor_name'],
      status: map['status'],
      height: map['height'],
      width: map['width'],
      totalPriceOfMaterials: map['totalPriceOfMaterials'],
      isReviewAndEnd: map['isReviewAndEnd'],
      materialSelected: map['materialSelected'],
      materials: (map['materials'])
          ?.map((materialMap) => MaterialModel.fromMap(materialMap))
          .toList(),
    );
  }
}
