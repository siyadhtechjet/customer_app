import 'package:customer_app/function/user_data.dart';
import 'package:customer_app/model/user_data.dart';
import 'package:customer_app/presentation/widgets/single_detail_card.dart';
import 'package:customer_app/presentation/widgets/space_between.dart';
import 'package:customer_app/presentation/widgets/status_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String phoneNumber;
  const DetailScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<UserDataProvider>(
          builder: (context, value, child) {
            return FutureBuilder<UserDataModel?>(
                future: value.getData(phoneNumber),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  DateTime now = DateTime.parse(snapshot.data!.visitedTime!);
                  String convertedDateTime =
                      "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SingleDetailCard(
                              dataTitle: 'Mobile Number:  ',
                              detail: data!.phoneNumber!,
                            ),
                            SingleDetailCard(
                              dataTitle: 'Address:  ',
                              detail: data.adress!,
                            ),
                            SingleDetailCard(
                              dataTitle: 'Industry:  ',
                              detail: data.industry!,
                            ),
                            SingleDetailCard(
                              dataTitle: 'Remark:  ',
                              detail: data.remark!,
                            ),
                            SingleDetailCard(
                                dataTitle: 'Visited time:  ',
                                detail: convertedDateTime),
                            SingleDetailCard(
                              dataTitle: 'Status:  ',
                              detail: data.status!,
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          StatusButton(
                            buttonFunction: () async {
                              await Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .updateStatus(data.phoneNumber!, 'Deal');
                            },
                            buttonName: 'Deal',
                          ),
                          const SpaceBetween(),
                          StatusButton(
                            buttonFunction: () async {
                              await Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .updateStatus(data.phoneNumber!, 'Follow up');
                            },
                            buttonName: 'Follow up',
                          ),
                          const SpaceBetween(),
                          StatusButton(
                            buttonFunction: () async {
                              await Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .updateStatus(
                                      data.phoneNumber!, 'Not interested');
                            },
                            buttonName: 'Not interested',
                          )
                        ],
                      )
                    ],
                  );
                });
          },
          // child:
        ),
      )),
    );
  }
}






