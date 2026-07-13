import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/modules/events/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class EventServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //  CollectionReference<EventModel> setEventData(EventModel event) {
  //    return firestore.collection("event").withConverter(
  //       fromFirestore: (snapshot, options) => EventModel.fromJson(snapshot.data()),
  //       toFirestore: (value, options) => value.toJson());
  //     //create rundom id of dicument
  //     // collection.add(event.toJson());

  //     //create docuemt with generate id y me
  //     // var document = collection.doc(event.id);
  //     // document.set(event.toJson());
  //   }

  static CollectionReference<EventModel> getRef() {
    return firestore
        .collection("event")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) {
            return EventModel.fromJson(snapshot.data());
          },
          toFirestore: (value, options) {
            return value.toJson();
          },
        );
  }

  static Future<void> addEvent(EventModel event) async {
    var ref = getRef();
    var doc = ref.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<void> deleteEvent(String eventId) async {
    var ref = getRef();
    return await ref.doc(eventId).delete();
  }

  static Future<void> updateEvent(EventModel event) async {
    var ref = getRef();
    return await ref.doc(event.id).update(event.toJson());
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getDate(
    int index,
    BuildContext context,
  ) async {
    var ref = getRef();
    if (index == 0) {
      var data = await ref.get();
      return data.docs;
    } else {
      var categoryId = AppConstance.categories(context)[index - 1].id;
      var date = await ref.where("categoryId", isEqualTo: categoryId).get();
      return date.docs;
    }
  }

  static Future<EventModel> getEventById(String event) async {
    var ref = getRef();
    var data = await ref.doc(event).get();
    return data.data()!;
  }

  static Stream<QuerySnapshot<EventModel>> getStreamDate(
    int index,
    BuildContext context,
  ) {
    var ref = getRef();
    if (index == 0) {
      var data = ref.snapshots();
      return data;
    } else {
      var categoryId = AppConstance.categories(context)[index - 1].id;
      var date = ref.where("categoryId", isEqualTo: categoryId).snapshots();
      return date;
    }
  }

  static Future<void> favToggle(EventModel event) async {
    // event.userfav ??= [];
    // if (event.isfav) {
    //   event.userfav!.remove(FirebaseAuth.instance.currentUser!.uid);
    //   event.isfav = false;
    // } else {
    //   event.userfav?.add(FirebaseAuth.instance.currentUser!.uid);
    //   event.isfav = true;
    // }

    var ref = getRef();
    if (event.isfav) {
     await ref.doc(event.id).update({
        "userfav": FieldValue.arrayRemove([
          FirebaseAuth.instance.currentUser!.uid,
        ]),
      });
     await ref.doc(event.id).update({"isfav": false});
    } else {
     await ref.doc(event.id).update({
        "userfav": FieldValue.arrayUnion([
          FirebaseAuth.instance.currentUser!.uid,
        ]),
      });
    await  ref.doc(event.id).update({"isfav": true});
    }
    // await ref.doc(event.id).update(event.toJson());
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>>
  getFavouriteDate() async {
    var ref = getRef();
    var data = await ref
        .where("userfav", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get();
    return data.docs;
  }

  //  static Future<List<QueryDocumentSnapshot<EventModel>>> searchFavoriteEvent(String eventTitle) async {
  //     var ref = getRef();
  //     var doc = await ref
  //         .where("title", isEqualTo: eventTitle)
  //         .where("userfav", arrayContains: FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     return doc.docs;
  //   }
  // }

  // class SrvicesData {
  //   setData() {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     var collection = firestore.collection("event");
  //     collection.doc("event_id").set({"name": "event"});
  //   }

  //   Future<List<EventModel>> getdData() async {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     var data = await firestore.collection("event").get();
  //     var eventList = data.docs.map((doc) {
  //       return EventModel.fromJson(doc.data());
  //     }).toList();
  //     return eventList;
  //   }

  //   Future<Map<String, dynamic>> getdDsata() async {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     var data = await firestore.collection("event").doc("event_id").get();
  //     // return EventModel.fromJson(data.data());
  //     Map<String, dynamic> mydata = data.data() as Map<String, dynamic>;
  //   mydata["id"] = data.id;
  //   mydata["ref"] = data.reference;
  //     return mydata;
  //   }
  // }

  // tooglefav(EventModel event) async {
  //   var uId = FirebaseAuth.instance.currentUser!.uid;
  //   var ref = FirebaseFirestore.instance.collection("event").doc(event.id);
  //   if (event.isfav) {
  //     ref.update({
  //       "userfav": FieldValue.arrayRemove([uId]),

  //     });
  //   }else {
  //     ref.update({
  //       "userfav": FieldValue.arrayUnion([uId]),
  //     });
  //   }
  // }

  // Future<List> getlistFavEvent() async {
  //   String userId = FirebaseAuth.instance.currentUser!.uid;
  //   var ref = FirebaseFirestore.instance.collection("favorites");
  //   var data = await ref.doc(userId).get();
  //   Map<String, dynamic>? mydata = data.data();
  //   List mylist = mydata!["events"];
  //   return mylist;
  // }

  // Future<EventModel> getEvent(String idEvent) async {
  //   var ref = FirebaseFirestore.instance.collection("event").doc(idEvent);
  //   var data = await ref.get();
  //   return EventModel.fromJson(data.data());
  // }

  // Future<List<EventModel>> loopfun() async {
  //   var newList = await getlistFavEvent();
  //   List<EventModel> event = [];
  //   for (var element in newList) {
  //     if (event.contains(element)) {}
  //     event.add(await getEvent(element));
  //   }
  //   return event;
  // }

  // Future<void> toggle(String eventId) async {
  //   var collection = FirebaseFirestore.instance.collection('favorites');
  //   String userId = FirebaseAuth.instance.currentUser!.uid;

  //   // جيب الـ list الأول
  //   var data = await collection.doc(userId).get();
  //   List list = data.data()!['events'] ?? [];

  //   if (list.contains(eventId)) {
  //     // موجود → شيله
  //     await collection.doc(userId).update({
  //       'events': FieldValue.arrayRemove([eventId]),
  //     });
  //   } else {
  //     // مش موجود → ضيفه
  //     await collection.doc(userId).update({
  //       'events': FieldValue.arrayUnion([eventId]),
  //     });
  //   }
  // }
}
