import 'package:flutter/material.dart';

class SingleDetailCard extends StatelessWidget {
  final String dataTitle;
  final String detail;
  const SingleDetailCard(
      {super.key, required this.dataTitle, required this.detail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Card(
            child: Center(
                child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(dataTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Expanded(
                  child: Text(
                detail,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              )),
            ],
          ),
        ))));
  }
}