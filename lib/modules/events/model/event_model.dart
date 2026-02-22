import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String id;
  String title;
  String description;
  String date;
  String time;
  String categoryId;
  List<dynamic>? userfav;
  bool isfav;

  EventModel({
    required this.categoryId,
    required this.date,
    required this.description,
    required this.id,
    required this.time,
    required this.title,
    this.userfav,
    this.isfav = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "categoryId": categoryId,
      "userfav": userfav,
      "isfav": isfav,
    };
  }

  factory EventModel.fromJson(dynamic json) {
    List<dynamic>? userFav = json["userfav"];
    String? userId = FirebaseAuth.instance.currentUser!.uid;

    return EventModel(
      categoryId: json["categoryId"],
      date: json["date"],
      description: json["description"],
      id: json["id"],
      time: json["time"],
      title: json["title"],
      userfav: json["userfav"],
      isfav: userFav != null && userFav.contains(userId),
    );
  }
}
