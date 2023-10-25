import 'package:customer_app/function/user_data.dart';
import 'package:customer_app/model/user_data.dart';
import 'package:customer_app/presentation/widgets/single_detail_card.dart';
import 'package:customer_app/presentation/widgets/space_between.dart';
import 'package:customer_app/presentation/widgets/status_button.dart';
import 'package:customer_app/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String phoneNumber;
  DetailScreen({super.key, required this.phoneNumber});

  final TextEditingController updateRemark = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Data empty'),
                    );
                  }
                  var data = snapshot.data;
                  DateTime now = DateTime.parse(snapshot.data!.visitedTime!);
                  String convertedDateTime =
                      "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
                  return ListView(
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
                            ),
                            const SpaceBetween(),
                            const SpaceBetween(),
                            TextFieldWidget(
                              controller: updateRemark,
                              content: 'Remark',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Column(
                        children: [
                          StatusButton(
                            buttonFunction: () async {
                              await Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .updateStatus(data.phoneNumber!, 'Deal',
                                      updateRemark.text.trim(), data.remark!);
                              updateRemark.clear();
                            },
                            buttonName: 'Deal',
                          ),
                          const SpaceBetween(),
                          StatusButton(
                            buttonFunction: () async {
                              await Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .updateStatus(data.phoneNumber!, 'Follow up',
                                      updateRemark.text.trim(), data.remark!);
                              updateRemark.clear();
                            },
                            buttonName: 'Follow up',
                          ),
                          const SpaceBetween(),
                          StatusButton(
                            buttonFunction: () async {
                              await Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .updateStatus(
                                      data.phoneNumber!,
                                      'Not interested',
                                      updateRemark.text.trim(),
                                      data.remark!);
                              updateRemark.clear();
                            },
                            buttonName: 'Not interested',
                          )
                        ],
                      )
                    ],
                  );
                });
          },
        ),
      )),
    );
  }
}
