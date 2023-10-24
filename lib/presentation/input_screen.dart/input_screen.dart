import 'package:customer_app/function/user_data.dart';
import 'package:customer_app/presentation/widgets/space_between.dart';
import 'package:customer_app/presentation/widgets/status_button.dart';
import 'package:customer_app/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatelessWidget {
  InputScreen({Key? key}) : super(key: key);

  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController industry = TextEditingController();
  final TextEditingController remark = TextEditingController();
  final TextEditingController visitedTime = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: mobileNumber,
                      content: 'Mobile Number',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length > 10 ||
                            value.length < 10) {
                          return 'Please enter Mobile Number with 10 numbers';
                        }
                        return null;
                      },
                    ),
                    const SpaceBetween(),
                    TextFieldWidget(
                      controller: address,
                      content: 'Address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Address';
                        }
                        return null;
                      },
                    ),
                    const SpaceBetween(),
                    TextFieldWidget(
                      controller: industry,
                      content: 'Industry',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Industry';
                        }
                        return null;
                      },
                    ),
                    const SpaceBetween(),
                    TextFieldWidget(
                      controller: remark,
                      content: 'Remark',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Remark';
                        }
                        return null;
                      },
                    ),
                    const SpaceBetween(),
                    SizedBox(
                        width: double.infinity,
                        child: StatusButton(
                            buttonFunction: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<UserDataProvider>().addData(
                                      mobileNumber.text,
                                      address.text,
                                      remark.text,
                                      industry.text,
                                    );
                                    Navigator.pop(context);
                              }
                            },
                            buttonName: 'Submit')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

