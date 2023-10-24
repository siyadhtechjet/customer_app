import 'package:flutter/material.dart';

class SpaceBetween extends StatelessWidget {
  const SpaceBetween({super.key});

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return  SizedBox(height: size.height*0.01,);
  }
}