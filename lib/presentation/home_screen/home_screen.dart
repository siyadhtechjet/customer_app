import 'package:customer_app/function/user_data.dart';
import 'package:customer_app/model/user_data.dart';
import 'package:customer_app/presentation/detail_screen/detail_screen.dart';
import 'package:customer_app/presentation/input_screen.dart/input_screen.dart';
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
          appBar: AppBar(title: const Text('CustomerApp')),
          body: SafeArea(
              child: FutureBuilder<List<UserDataModel>>(
            future: value.getAllData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                const Center(
                  child: Text('Data empty'),
                );
              }
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
                          return SizedBox(
                            height: size.height * 0.1,
                            child: Card(
                              child: Center(
                                child: ListTile(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete'),
                                        content:
                                            const Text('Do yo want to delete'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('CANCEL',),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'DELETE',),
                                            onPressed: () async {
                                              context
                                                  .read<
                                                      UserDataProvider>()
                                                  .deleteData(snapshot.data![index].phoneNumber.toString());
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  
                                },
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
                                  title:
                                      Text(snapshot.data![index].phoneNumber!),
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
