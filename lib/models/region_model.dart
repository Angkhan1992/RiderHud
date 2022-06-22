import 'dart:convert';

class RegionModel {
  String id;
  String title;
  String title_ar;
  List<Vertice> vertices = [];

  RegionModel({
    this.id,
    this.title,
    this.title_ar,
    this.vertices,
  });

  Map<String, dynamic> toMap() {
    var mapArray = [];
    for (var vertice in vertices) {
      mapArray.add(vertice.toMap());
    }
    return {
      'id': id,
      'title': title,
      'title_ar': title_ar,
      'vertices' : mapArray,
    };
  }

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    var stringArray = map['vertices'];
    List<Vertice> vertices = [];
    if (stringArray != null) {
      for (var json in jsonDecode(stringArray)) {
        vertices.add(Vertice.fromMap(json));
      }
    }
    return RegionModel(
      id: map['id'],
      title: map['title'],
      title_ar: map['title_ar'],
      vertices: vertices,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionModel.fromJson(String source) =>
      RegionModel.fromMap(json.decode(source));
}

class Vertice {
  double lat;
  double lng;

  Vertice({this.lat, this.lng});

  factory Vertice.fromMap(Map<String, dynamic> map) {
    return Vertice(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': this.lat,
      'lng': this.lng,
    };
  }
}
