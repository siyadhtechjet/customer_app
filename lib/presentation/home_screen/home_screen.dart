import 'package:customer_app/presentation/detail_screen/detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('CustomerApp')),
      body: SafeArea(child: ListView.builder(itemBuilder: 
      (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(),));
          },
          leading:const CircleAvatar(),
          title: Text('data$index'),
        );
      },)),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: const Icon(Icons.add),),
    );
  }
}