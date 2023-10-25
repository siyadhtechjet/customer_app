import 'package:customer_app/function/user_data.dart';
import 'package:customer_app/model/user_data.dart';
import 'package:customer_app/presentation/detail_screen/detail_screen.dart';
import 'package:customer_app/presentation/update_screen/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SearchBar(
                  trailing: [
                    IconButton(onPressed: () {
                      searchController.clear();
                    }, icon:const Icon(Icons.clear,color: Colors.grey,))
                    ],
                  hintText: 'Search',
                  hintStyle: const MaterialStatePropertyAll(
                      TextStyle(color: Colors.grey,fontSize: 16)),
                  controller: searchController,
                  onSubmitted: (value) =>
                      context.read<UserDataProvider>().filterItems(value),
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: Consumer<UserDataProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<List<UserDataModel>>(
                    future: value.filterItems(searchController.text),
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
                        return ListView.builder(
                          padding: const EdgeInsets.all(15),
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
                                                        dataAddress:
                                                            data.adress!,
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
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
