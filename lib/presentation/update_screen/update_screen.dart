import 'package:customer_app/function/user_data.dart';
import 'package:customer_app/presentation/widgets/space_between.dart';
import 'package:customer_app/presentation/widgets/status_button.dart';
import 'package:customer_app/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  final String mobileNumber;
  final String dataName;
  final String dataAddress;
  final String dataRequirment;
  final String dataIndustry;
  UpdateScreen({
    super.key,
    required this.mobileNumber,
    required this.dataName,
    required this.dataAddress,
    required this.dataRequirment,
    required this.dataIndustry,
  });

  final TextEditingController address = TextEditingController();
  final TextEditingController industry = TextEditingController();
  final TextEditingController remark = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController requirment = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    address.text=dataAddress;
    name.text=dataName;
    industry.text=dataIndustry;
    requirment.text=dataRequirment;
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
                      controller: name,
                      content: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SpaceBetween(),
                    TextFieldWidget(
                      controller: requirment,
                      content: 'Requirment',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your requirment';
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
                    SizedBox(
                        width: double.infinity,
                        child: StatusButton(
                            buttonFunction: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<UserDataProvider>().updateData(
                                    address.text,
                                    industry.text,
                                    mobileNumber,
                                    name.text,
                                    requirment.text);
                                Navigator.pop(context);
                              }
                            },
                            buttonName: 'update')),
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
