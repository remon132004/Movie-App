import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.suffixIcon,  this.controller, this.textColor, this.onChanged,
  });

 final  TextEditingController? controller;

  final bool? readOnly;
  final void Function()? onTap;
  final String? hintText;
  final Widget? suffixIcon;
  final Color? textColor;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      style: TextStyle(
        color: textColor
      ),
      readOnly: readOnly!,
      cursorColor: AppColors.white,
      decoration: InputDecoration(

          suffixIcon: suffixIcon,
          hintText: hintText,
          filled: true,
          fillColor: AppColors.grey,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16))),
      onTap: onTap,
    );
  }
}
