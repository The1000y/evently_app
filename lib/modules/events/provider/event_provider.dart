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
    Loading.showLoading(context);
    EventModel event = EventModel(
      categoryId: AppConstance.categories[tabIndex].id,
      date: selectedDate.toString(),
      description: descriptionController.text,
      id: "",
      time: selectedTime!.format(context),
      title: titleController.text,
    );
    await EventServices.addEvent(event);
    clear();
    Loading.hideLoading(context);
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
