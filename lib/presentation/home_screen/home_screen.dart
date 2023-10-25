import 'package:customer_app/function/user_data.dart';
import 'package:customer_app/model/user_data.dart';
import 'package:customer_app/presentation/detail_screen/detail_screen.dart';
import 'package:customer_app/presentation/input_screen.dart/input_screen.dart';
import 'package:customer_app/presentation/search_screen/search_screen.dart';
import 'package:customer_app/presentation/update_screen/update_screen.dart';
import 'package:customer_app/presentation/widgets/count_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('CustomerApp'),actions: [IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
          }, icon:const Icon(Icons.search))],),
          body: SafeArea(
              child: FutureBuilder<List<UserDataModel>>(
            future: value.getAllData(),
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
              } else {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              CountData(
                                count: value.deal.toString(),
                                status: 'Deal',
                              ),
                              const Divider(),
                              CountData(
                                count: value.followup.toString(),
                                status: 'Follow up',
                              ),
                              const Divider(),
                              CountData(
                                count: value.notinterested.toString(),
                                status: 'Not interested',
                              ),
                              const Divider(),
                              CountData(
                                count: snapshot.data!.length.toString(),
                                status: 'Total',
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 5),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            int indexnum = index + 1;
                            var data = snapshot.data![index];
                            return SizedBox(
                              height: size.height * 0.1,
                              child: Card(
                                child: Center(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                phoneNumber: snapshot
                                                    .data![index].phoneNumber!),
                                          ));
                                    },
                                    leading: CircleAvatar(
                                      child: Text(indexnum.toString()),
                                    ),
                                    title: Text(
                                      data.name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      data.phoneNumber!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateScreen(
                                                        mobileNumber:
                                                            data.phoneNumber!,
                                                        dataAddress: data.adress!,
                                                        dataIndustry:
                                                            data.industry!,
                                                        dataName: data.name!,
                                                        dataRequirment:
                                                            data.requirment!),
                                              ));
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InputScreen(),
                  ));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
