class ToolsModel {
  String? type;
  String? message;
  List<ToolsData>? data;

  ToolsModel({this.type, this.message, this.data});

  ToolsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ToolsData>[];
      json['data'].forEach((v) {
        data!.add(ToolsData.fromJson(v));
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

class ToolsData {
  String? toolId;
  String? name;
  int? price;
  String? description;
  String? imageUrl;

  ToolsData({this.toolId, this.name, this.description, this.imageUrl,this.price});

  ToolsData.fromJson(Map<String, dynamic> json) {
    toolId = json['toolId'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toolId'] = toolId;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
