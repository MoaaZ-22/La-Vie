class SeedsModel {
  String? type;
  String? message;
  List<SeedsData>? data;

  SeedsModel({this.type, this.message, this.data});

  SeedsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SeedsData>[];
      json['data'].forEach((v) {
        data!.add(SeedsData.fromJson(v));
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

class SeedsData {
  String? seedId;
  String? name;
  int? price;
  String? description;
  String? imageUrl;

  SeedsData({this.seedId, this.name, this.description, this.imageUrl,this.price});

  SeedsData.fromJson(Map<String, dynamic> json) {
    seedId = json['seedId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seedId'] = seedId;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
