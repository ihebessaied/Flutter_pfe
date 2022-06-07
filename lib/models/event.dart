
// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    Event({
        required this.id,
        required this.label,
        required this.price,
        required this.dateevent,
        required this.lieux,
        required this.description,
        required this.photo,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String label;
    String price;
    DateTime dateevent;
    String lieux;
    String description;
    String photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        label: json["label"],
        price: json["price"],
        dateevent: DateTime.parse(json["dateevent"]),
        lieux: json["lieux"],
        description: json["description"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "price": price,
        "dateevent": "${dateevent.year.toString().padLeft(4, '0')}-${dateevent.month.toString().padLeft(2, '0')}-${dateevent.day.toString().padLeft(2, '0')}",
        "lieux": lieux,
        "description": description,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
































// class Event {
//   int id;
//   String label;
//   String price;
//   String dateevent;
//   String lieux;
//   String Description;
//   String photo;

//   Event(
//       {required this.id,
//       required this.label,
//       required this.price,
//       required this.dateevent,
//       required this.lieux,
//       required this.Description,
//       required this.photo});

//   Event.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         label = json['label'],
//         price = json['price'],
//         dateevent = json['dateevent'],
//         lieux = json['lieux'],
//         Description = json['Description'],
//         photo = json['photo'];
// }
