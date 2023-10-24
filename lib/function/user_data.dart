import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/model/user_data.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  int deal = 0;
  int followup = 0;
  int notinterested = 0;
  Future<void> addData(String phoneNumber, String address, String remark,
      String industry) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('data');

      Map<String, dynamic> userData = {
        'phone_number': phoneNumber,
        'adress': address,
        'remark': remark,
        'Industry': industry,
        'visited_time': DateTime.now().toString(),
        'status': 'None',
      };

      await dataCollection.doc(phoneNumber).set(userData);

      notifyListeners();
    } catch (error) {
      log("Error in adding: $error");
    }
  }

  Future<List<UserDataModel>> getAllData() async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('data');

      QuerySnapshot querySnapshot = await dataCollection.get();

      List<UserDataModel> dataList = [];
      deal = 0;
      followup = 0;
      notinterested = 0;
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        UserDataModel userData = UserDataModel.fromJson(dataMap);
        dataList.add(userData);
      }
      for (var element in dataList) {
        if (element.status == 'Deal') {
          deal++;
        } else if (element.status == 'Follow up') {
          followup++;
        } else if (element.status == 'Not interested') {
          notinterested++;
        }
      }
      return dataList;
    } catch (error) {
      log("Error in getting all data: $error");
      return [];
    }
  }

  Future<UserDataModel?> getData(String phoneNumber) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> postSnapshot =
          await FirebaseFirestore.instance
              .collection('data')
              .doc(phoneNumber)
              .get();

      Map<String, dynamic> data = postSnapshot.data()!;
      UserDataModel userData = UserDataModel.fromJson(data);
      return userData;
    } catch (error) {
      log("Error in getting all data: $error");
      return null;
    }
  }

  Future<void> updateStatus(String phoneNumber, String status) async {
    try {
      notifyListeners();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('data');

      await usersCollection.doc(phoneNumber).update({
        'visited_time': DateTime.now().toString(),
        'status': status,
      });
      notifyListeners();
    } catch (error) {
      log("Error adding/updating data: $error");
    }
  }

  Future<void> deleteData(String mobileNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('data')
          .doc(mobileNumber)
          .delete();
      notifyListeners();
      log('Successfully Deleted');
    } catch (e) {
      log('Error in delete: $e');
    }
  }
}
