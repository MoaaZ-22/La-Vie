

class PlantsModel {
  String? type;
  String? message;
  List<PlantsData>? data;

  PlantsModel({this.type, this.message, this.data});

  PlantsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlantsData>[];
      json['data'].forEach((v) {
        data!.add(PlantsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlantsData {
  String? plantId;
  String? name;
  String? description;
  String? imageUrl;
  int? price;
  int? waterCapacity;
  int? sunLight;
  int? temperature;

  PlantsData(
      {this.plantId,
        this.name,
        this.description,
        this.imageUrl,
        this.price,
        this.waterCapacity,
        this.sunLight,
        this.temperature});

  PlantsData.fromJson(Map<String, dynamic> json) {
    plantId = json['plantId'];
    name = json['name'];
    description = json['description'];
    imageUrl =  json['imageUrl'];
    price = json['price'];
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plantId'] = plantId;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['waterCapacity'] = waterCapacity;
    data['sunLight'] = sunLight;
    data['temperature'] = temperature;
    return data;
  }
}
