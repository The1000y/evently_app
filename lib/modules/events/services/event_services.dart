import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/modules/events/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  static Future<List<QueryDocumentSnapshot<EventModel>>> getDate(
    int index,
  ) async {
    var ref = getRef();
    if (index == 0) {
      var data = await ref.get();
      return data.docs;
    } else {
      var categoryId = AppConstance.categories[index - 1].id;
      var date = await ref.where("categoryId", isEqualTo: categoryId).get();
      return date.docs;
    }
  }

  static Stream<QuerySnapshot<EventModel>> getStreamDate(int index) {
    var ref = getRef();
    if (index == 0) {
      var data = ref.snapshots();
      return data;
    } else {
      var categoryId = AppConstance.categories[index - 1].id;
      var date = ref.where("categoryId", isEqualTo: categoryId).snapshots();
      return date;
    }
  }

  static Future<void> favToggle(EventModel event) async {
    event.userfav ??= [];
    if (event.isfav) {
      event.userfav!.remove(FirebaseAuth.instance.currentUser!.uid);
      event.isfav = false;
    } else {
      event.userfav?.add(FirebaseAuth.instance.currentUser!.uid);
      event.isfav = true;
    }

    var ref = getRef();
    await ref.doc(event.id).update(event.toJson());
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>>
  getFavouriteDate() async {
    var ref = getRef();
    var data = await ref
        .where("userfav", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get();
    return data.docs;
  }
}
