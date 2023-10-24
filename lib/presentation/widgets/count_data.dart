import 'package:flutter/material.dart';

class CountData extends StatelessWidget {
  final String status;
  final String count;
  const CountData({
    super.key,
    required this.count,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(status,style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
      trailing: Text(count,style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}