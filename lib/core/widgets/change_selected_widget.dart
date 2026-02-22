import 'package:flutter/material.dart';

enum SelectedType { button1, button2 }

// ignore: must_be_immutable
class CustomRowChoose extends StatelessWidget {
  CustomRowChoose({
    super.key,
    required this.textOfRow,
    required this.type,
    required this.child1,
    required this.child2,
    required this.ontap,
  });
  String textOfRow;
  SelectedType type;
  Widget child1;
  Widget child2;
  Function(SelectedType) ontap;

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: Text(
            textDirection: TextDirection.ltr,
            textOfRow,
            style: myTheme.textTheme.titleMedium,
          ),
        ),

        GestureDetector(
          onTap: () {
            ontap(SelectedType.button1);

            // widget.type = SelectedType.button1;
          },
          child: Card(
            elevation: type == SelectedType.button1 ? null : 0,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: type == SelectedType.button1
                  ? BorderSide.none
                  : BorderSide(width: 0.6, color: myTheme.primaryColor),
            ),

            color: type == SelectedType.button1
                ? myTheme.primaryColor
                : Colors.transparent,
            child: child1,
          ),
        ),

        GestureDetector(
          onTap: () {
            ontap(SelectedType.button2);
            // widget.type = SelectedType.button2;s
          },
          child: Card(
            elevation: type == SelectedType.button2 ? null : 0,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: type == SelectedType.button2
                  ? BorderSide.none
                  : BorderSide(width: 0.6, color: myTheme.primaryColor),
            ),

            color: type == SelectedType.button2
                ? myTheme.primaryColor
                : Colors.transparent,
            child: child2,
          ),
        ),
      ],
    );
  }
}
