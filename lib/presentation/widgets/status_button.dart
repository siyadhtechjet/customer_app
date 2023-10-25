import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  final String buttonName;
  final Function() buttonFunction;
  const StatusButton(
      {super.key, required this.buttonFunction, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height*0.06,
      child: ElevatedButton(
          onPressed: () {
            buttonFunction();
          },
          child: Text(buttonName,style:const TextStyle(fontSize: 17),)),
    );
  }
}