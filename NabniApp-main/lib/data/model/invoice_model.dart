import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/view/screen/contractor/choose_material_screen.dart';

class InvoiceModel {
  String? id;
  String? clientName;
  String? contractorName;
  String? priceWork;
  String? client_id;
  String? contractor_id;
  String? project_id;
  String? is_confirmed_by_client;
  List<MaterialModel>? items;

  InvoiceModel({
    this.id,
    this.clientName,
    this.contractorName,
    this.priceWork,
    this.client_id,
    this.contractor_id,
    this.project_id,
    this.is_confirmed_by_client,
    this.items,
  });

  // Convert InvoiceModel to a map for storage
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['clientName'] = clientName;
    map['contractorName'] = contractorName;
    map['priceWork'] = priceWork;
    map['client_id'] = client_id;
    map['contractor_id'] = contractor_id;
    map['project_id'] = project_id;
    map['is_confirmed_by_client'] = is_confirmed_by_client;

    // Convert items to a list of maps
    map['items'] = items?.map((item) => item.toMap()).toList();

    return map;
  }

  // Create an InvoiceModel object from a map
  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'],
      clientName: map['clientName'],
      contractorName: map['contractorName'],
      client_id: map['client_id'],
      contractor_id: map['contractor_id'],
      project_id: map['project_id'],
      priceWork: map['priceWork'],
      is_confirmed_by_client: map['is_confirmed_by_client'].toString(),

      // Convert the list of maps back to a list of MaterialModel objects
      items: List<MaterialModel>.from(
          map['items']?.map((itemMap) => MaterialModel.fromMap(itemMap))),
    );
  }
}
