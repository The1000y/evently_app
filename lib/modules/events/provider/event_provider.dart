import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/core/widgets/loading.dart';
import 'package:evently/modules/events/model/event_model.dart';
import 'package:evently/modules/events/services/event_services.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  int tabIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  Future<void> onAddEvent(BuildContext context) async {
    try {
      Loading.showLoading(context);
      EventModel event = EventModel(
        categoryId: AppConstance.categories(context)[tabIndex].id,
        date: selectedDate.toString(),
        description: descriptionController.text,
        id: "",
        time: selectedTime!.format(context),
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
