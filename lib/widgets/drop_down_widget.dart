import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final List<DropdownMenuItem<String>> dropDownItemList;
  final Function(String) onItemSelect;
  final dynamic selectedValue;
  final String hintTitle;

  const DropDownWidget({
    Key? key,
    required this.dropDownItemList,
    required this.onItemSelect,
    this.selectedValue,
    required this.hintTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedValue,
      hint: Text(
        hintTitle,
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.end,
      ),
      items: dropDownItemList,
      onChanged: (value) {
        if (value != null) {
          onItemSelect(value.toString());
        }
      },
      icon: const Icon(Icons.arrow_drop_down_sharp),
      isDense: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
      ),
    );
  }
}
