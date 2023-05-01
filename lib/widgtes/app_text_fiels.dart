import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType type;
  final IconData prefixIcon;
  final String hint;
  final bool obscures;
  final IconData? suffixIcon;
  final  Function()? onPressedSuffix;

 const  AppTextField({
    required this.controller,
    required this.prefixIcon,
    required this.hint,
    this.suffixIcon,
    this.onPressedSuffix,
     this.type = TextInputType.text,
    this.obscures = false
});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText:hint ,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(onPressed:onPressedSuffix, icon: Icon(suffixIcon),),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),

      ),
      keyboardType: type,
      obscureText: obscures,
      controller: controller,


    );
  }
}
