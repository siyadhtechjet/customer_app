import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey,
              child:const Column(
                children: [
                  SingleDetailCard(detail: 'Mobile Number: ',),
                  SingleDetailCard(detail: 'Address: ',),
                  SingleDetailCard(detail: 'Industry: ',),
                  SingleDetailCard(detail: 'Remark: ',),
                  SingleDetailCard(detail: 'Visited time: ',),
                  SingleDetailCard(detail: 'Status: ',)
                ],
              ),
            ),
            Column(
              children: [
                StatusButton(
                  buttonFunction: () {
                    
                  },
                  buttonName: 'Cancel',
                ),
                StatusButton(
                  buttonFunction: () {
                    
                  },
                  buttonName: 'Accepted',
                ),StatusButton(
                  buttonFunction: () {
                    
                  },
                  buttonName: 'FollowUp',
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}

class SingleDetailCard extends StatelessWidget {
  final String detail;
  const SingleDetailCard({
    super.key,
    required this.detail
  });

  @override
  Widget build(BuildContext context) {
     var size= MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height*0.08,
      child: Card(child: Center(child: Text(detail))));
  }
}

class StatusButton extends StatelessWidget {
  final String buttonName;
  final Function() buttonFunction;
  const StatusButton({
    super.key,
    required this.buttonFunction,
    required this.buttonName
  });

  @override
  Widget build(BuildContext context) {
    // var size= MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: () {
        buttonFunction;
      }, child: Text(buttonName)),
    );
  }
}