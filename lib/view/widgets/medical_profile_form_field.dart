import 'package:flutter/material.dart';

class MedicalProfileFormFiled extends StatelessWidget {

  final TextEditingController controller;
  final bool obscureText;
  final Function validator;
  final String hintText;


  const MedicalProfileFormFiled({

    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.hintText,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      maxLines: 5,
      controller:controller ,
      obscureText:obscureText ,
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      validator: (value)=>validator(value),
      decoration: InputDecoration(

        fillColor: Colors.grey.shade200,
        hintText:hintText,
        helperStyle:const TextStyle(
          color: Colors.black45,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
