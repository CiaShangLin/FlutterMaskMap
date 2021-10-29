// {
// "type": "Feature",
// "properties": {
// "id": "5901010076",
// "name": "榮星藥局",
// "phone": "(02)27124696",
// "address": "臺北市松山區南京東路４段１３３巷５弄１號",
// "mask_adult": 1290,
// "mask_child": 740,
// "updated": "2021/09/25 10:53:31",
// "available": "星期一上午看診、星期二上午看診、星期三上午看診、星期四上午看診、星期五上午看診、星期六上午看診、星期日上午看診、星期一下午看診、星期二下午看診、星期三下午看診、星期四下午看診、星期五下午看診、星期六下午看診、星期日下午看診、星期一晚上看診、星期二晚上看診、星期三晚上看診、星期四晚上看診、星期五晚上看診、星期六晚上看診、星期日晚上休診",
// "note": "-",
// "custom_note": "",
// "website": "",
// "county": "臺北市",
// "town": "松山區",
// "cunli": "東勢里",
// "service_periods": "NNNNNNNNNNNNNNNNNNNNY"
// },
// "geometry": {
// "type": "Point",
// "coordinates": [
// 121.555235,
// 25.052137
// ]
// }
// }


class MaskBean {
  String? _type;
  List<Features>? _features;

  String? get type => _type;
  List<Features>? get features => _features;

  MaskBean({
      String? type,
      List<Features>? features}){
    _type = type;
    _features = features;
}

  MaskBean.fromJson(dynamic json) {
    _type = json["type"];
    if (json["features"] != null) {
      _features = [];
      json["features"].forEach((v) {
        _features?.add(Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    if (_features != null) {
      map["features"] = _features?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : "Feature"
/// properties : {"id":"5901010076","name":"榮星藥局","phone":"(02)27124696","address":"臺北市松山區南京東路４段１３３巷５弄１號","mask_adult":1290,"mask_child":740,"updated":"2021/09/25 10:53:31","available":"星期一上午看診、星期二上午看診、星期三上午看診、星期四上午看診、星期五上午看診、星期六上午看診、星期日上午看診、星期一下午看診、星期二下午看診、星期三下午看診、星期四下午看診、星期五下午看診、星期六下午看診、星期日下午看診、星期一晚上看診、星期二晚上看診、星期三晚上看診、星期四晚上看診、星期五晚上看診、星期六晚上看診、星期日晚上休診","note":"-","custom_note":"","website":"","county":"臺北市","town":"松山區","cunli":"東勢里","service_periods":"NNNNNNNNNNNNNNNNNNNNY"}
/// geometry : {"type":"Point","coordinates":[121.555235,25.052137]}

class Features {
  String? _type;
  Properties? _properties;
  Geometry? _geometry;

  String? get type => _type;
  Properties? get properties => _properties;
  Geometry? get geometry => _geometry;

  Features({
      String? type,
      Properties? properties,
      Geometry? geometry}){
    _type = type;
    _properties = properties;
    _geometry = geometry;
}

  Features.fromJson(dynamic json) {
    _type = json["type"];
    _properties = json["properties"] != null ? Properties.fromJson(json["properties"]) : null;
    _geometry = json["geometry"] != null ? Geometry.fromJson(json["geometry"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    if (_properties != null) {
      map["properties"] = _properties?.toJson();
    }
    if (_geometry != null) {
      map["geometry"] = _geometry?.toJson();
    }
    return map;
  }

}

/// type : "Point"
/// coordinates : [121.555235,25.052137]

class Geometry {
  String? _type;
  List<double>? _coordinates;

  String? get type => _type;
  List<double>? get coordinates => _coordinates;

  Geometry({
      String? type,
      List<double>? coordinates}){
    _type = type;
    _coordinates = coordinates;
}

  Geometry.fromJson(dynamic json) {
    _type = json["type"];
    _coordinates = json["coordinates"] != null ? json["coordinates"].cast<double>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    map["coordinates"] = _coordinates;
    return map;
  }

}

/// id : "5901010076"
/// name : "榮星藥局"
/// phone : "(02)27124696"
/// address : "臺北市松山區南京東路４段１３３巷５弄１號"
/// mask_adult : 1290
/// mask_child : 740
/// updated : "2021/09/25 10:53:31"
/// available : "星期一上午看診、星期二上午看診、星期三上午看診、星期四上午看診、星期五上午看診、星期六上午看診、星期日上午看診、星期一下午看診、星期二下午看診、星期三下午看診、星期四下午看診、星期五下午看診、星期六下午看診、星期日下午看診、星期一晚上看診、星期二晚上看診、星期三晚上看診、星期四晚上看診、星期五晚上看診、星期六晚上看診、星期日晚上休診"
/// note : "-"
/// custom_note : ""
/// website : ""
/// county : "臺北市"
/// town : "松山區"
/// cunli : "東勢里"
/// service_periods : "NNNNNNNNNNNNNNNNNNNNY"

class Properties {
  String? _id;
  String? _name;
  String? _phone;
  String? _address;
  int? _maskAdult;
  int? _maskChild;
  String? _updated;
  String? _available;
  String? _note;
  String? _customNote;
  String? _website;
  String? _county;
  String? _town;
  String? _cunli;
  String? _servicePeriods;

  String? get id => _id;
  String? get name => _name;
  String? get phone => _phone;
  String? get address => _address;
  int? get maskAdult => _maskAdult;
  int? get maskChild => _maskChild;
  String? get updated => _updated;
  String? get available => _available;
  String? get note => _note;
  String? get customNote => _customNote;
  String? get website => _website;
  String? get county => _county;
  String? get town => _town;
  String? get cunli => _cunli;
  String? get servicePeriods => _servicePeriods;

  Properties({
      String? id,
      String? name,
      String? phone,
      String? address,
      int? maskAdult,
      int? maskChild,
      String? updated,
      String? available,
      String? note,
      String? customNote,
      String? website,
      String? county,
      String? town,
      String? cunli,
      String? servicePeriods}){
    _id = id;
    _name = name;
    _phone = phone;
    _address = address;
    _maskAdult = maskAdult;
    _maskChild = maskChild;
    _updated = updated;
    _available = available;
    _note = note;
    _customNote = customNote;
    _website = website;
    _county = county;
    _town = town;
    _cunli = cunli;
    _servicePeriods = servicePeriods;
}

  Properties.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _phone = json["phone"];
    _address = json["address"];
    _maskAdult = json["mask_adult"];
    _maskChild = json["mask_child"];
    _updated = json["updated"];
    _available = json["available"];
    _note = json["note"];
    _customNote = json["custom_note"];
    _website = json["website"];
    _county = json["county"];
    _town = json["town"];
    _cunli = json["cunli"];
    _servicePeriods = json["service_periods"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["phone"] = _phone;
    map["address"] = _address;
    map["mask_adult"] = _maskAdult;
    map["mask_child"] = _maskChild;
    map["updated"] = _updated;
    map["available"] = _available;
    map["note"] = _note;
    map["custom_note"] = _customNote;
    map["website"] = _website;
    map["county"] = _county;
    map["town"] = _town;
    map["cunli"] = _cunli;
    map["service_periods"] = _servicePeriods;
    return map;
  }

}