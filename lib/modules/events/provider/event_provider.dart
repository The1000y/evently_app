import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/widgets/loading.dart';
import 'package:evently/modules/events/model/event_model.dart';
import 'package:evently/modules/events/services/event_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventProvider extends ChangeNotifier {
  int tabIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  String currentEventId = '';

  var currentUserId = FirebaseAuth.instance.currentUser!.uid;

  void onChangeTab(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void onSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void onSelectedTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  Future<void> onDeleteEvent(String eventId, BuildContext context) async {
    try {
      Loading.showLoading(context);
      await EventServices.deleteEvent(eventId);
      Loading.hideLoading(context);

      CherryToast.success(
        animationType: AnimationType.fromTop,
        title: Text("Event Deleted", textAlign: TextAlign.center),
      ).show(context);
      Navigator.pop(context);

      notifyListeners();
    } on Exception catch (e) {
      Loading.hideLoading(context);
      CherryToast.error(title: Text(e.toString())).show(context);
    } catch (e) {
      Loading.hideLoading(context);
      CherryToast.error(title: Text(e.toString())).show(context);
    }
  }

  Future<void> onUpdateEvent(BuildContext context) async {
    try {
      var oldEvent = await EventServices.getEventById(currentEventId);

      EventModel event = EventModel(
        userId: currentUserId,
        categoryId: AppConstance.categories(context)[tabIndex].id,
        date: selectedDate.toString(),
        description: descriptionController.text,
        id: currentEventId,
        time: selectedTime!.format(context),
        title: titleController.text,
        userfav: oldEvent.userfav,
      );

      Loading.showLoading(context);
      await EventServices.updateEvent(event);
      Loading.hideLoading(context);

      CherryToast.success(
        animationType: AnimationType.fromTop,
        title: Text("Event Updated", textAlign: TextAlign.center),
      ).show(context);

      clear();

      Navigator.pushReplacementNamed(context, AppIds.layoutScreen);
    } on FirebaseException catch (e) {
      Loading.hideLoading(context);
      CherryToast.error(title: Text(e.toString())).show(context);
    } catch (e) {
      Loading.hideLoading(context);
      CherryToast.error(title: Text(e.toString())).show(context);
    }
  }

  //  Future<void> onSearchEvent(String query) async{
  //    searchList = await EventServices.searchFavoriteEvent(query);

  //     notifyListeners();
  //   }

  Future<void> onAddEvent(BuildContext context) async {
    try {
      Loading.showLoading(context);
      EventModel event = EventModel(
        userId: currentUserId,
        categoryId: AppConstance.categories(context)[tabIndex].id,
        date: selectedDate?.toString() ?? DateTime.now().toString(),
        description: descriptionController.text,
        id: "",
        time:
            selectedTime?.format(context) ??
            DateFormat("hh:mm a").format(DateTime.now()),
        title: titleController.text,
      );
      await EventServices.addEvent(event);
      clear();
      CherryToast.success(
        animationType: AnimationType.fromTop,
        title: Text("Event Added", textAlign: TextAlign.center),
      ).show(context);
      Loading.hideLoading(context);
    } on FirebaseException catch (e) {
      Loading.hideLoading(context);
      CherryToast.error(title: Text(e.toString())).show(context);
    } catch (e) {
      Loading.hideLoading(context);
      CherryToast.error(title: Text(e.toString())).show(context);
    }
  }

  void initWithEvent(EventModel event, BuildContext context) {
    titleController.text = event.title;
    currentEventId = event.id;
    descriptionController.text = event.description;
    selectedDate = DateTime.parse(event.date);
    final timeParts = event.time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1].split(' ')[0]);
    final period = event.time.toLowerCase().contains('pm');
    selectedTime = TimeOfDay(
      hour: period && hour != 12
          ? hour + 12
          : (!period && hour == 12 ? 0 : hour),
      minute: minute,
    );
    int index = AppConstance.categories(
      context,
    ).indexWhere((element) => element.id == event.categoryId);

    if (index == -1) {
      index = 0;
    }

    tabIndex = index;

    notifyListeners();
  }

  void clear() {
    selectedDate = null;
    selectedTime = null;
    titleController.clear();
    descriptionController.clear();
    tabIndex = 0;
    notifyListeners();
  }
}
