import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final controller;
  final String hinttext;
  final bool obsecuretext;
  final IconData icon;

  const Mytextfield({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.obsecuretext,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child:
      TextField(
        controller: controller,
        obscureText: obsecuretext,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: Colors.grey[600],),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hinttext
        ),
      ),
    );
  }
}
