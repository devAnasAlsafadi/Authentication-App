import 'package:flutter/material.dart';
class CodeTextField extends StatelessWidget {


  final TextEditingController controller;
  final Function(String value) onChanged;
  final FocusNode node;

  CodeTextField({super.key,
    required this.controller,
    required this.node,
    required this.onChanged,
});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
      controller: controller,
      maxLength: 1,
      focusNode:node ,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: '',
        border: border(color: Colors.grey),
        focusedBorder: border(color: Colors.blue),
      ),
    );
  }

  OutlineInputBorder border({required Color color}) {
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: color,
              width:1
          )
      );
  }
}
