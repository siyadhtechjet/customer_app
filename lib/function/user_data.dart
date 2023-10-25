import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/model/user_data.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  int deal = 0;
  int followup = 0;
  int notinterested = 0;
  List<UserDataModel> dataList = [];

  Future<void> addData(
      {required String phoneNumber,
      required String address,
      required String remark,
      required String industry,
      required String name,
      required String requirment}) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('data');

      Map<String, dynamic> userData = {
        'phone_number': phoneNumber,
        'name': name,
        'requirment': requirment,
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
    dataList = [];
    final List<UserDataModel> newList = [];
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('data');

      QuerySnapshot querySnapshot = await dataCollection.get();

      deal = 0;
      followup = 0;
      notinterested = 0;
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        UserDataModel userData = UserDataModel.fromJson(dataMap);
        newList.add(userData);
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
      return newList;
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

  Future<void> updateStatus(String phoneNumber, String status,
      String updateRemark, String oldRemark) async {
    try {
      notifyListeners();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('data');

      await usersCollection.doc(phoneNumber).update({
        'visited_time': DateTime.now().toString(),
        'status': status,
        'remark': updateRemark.isEmpty ? oldRemark : updateRemark
      });
      notifyListeners();
    } catch (error) {
      log("Error adding/updating data: $error");
    }
  }

  Future<void> updateData(String address, String industry, String mobileNumber,
      String name, String requirment) async {
    try {
      notifyListeners();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('data');

      await usersCollection.doc(mobileNumber).update({
        'adress': address,
        'name': name,
        'requirment': requirment,
        'Industry': industry,
      });
      notifyListeners();
    } catch (error) {
      log("Error updating data: $error");
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

  List<UserDataModel> filteredItems = [];

  Future<List<UserDataModel>> filterItems(String query) async {
    try {
      if (query.isEmpty) {
        filteredItems.clear();
      } else {
        filteredItems = dataList
            .where((element) =>
                element.name!
                    .toLowerCase()
                    .contains(query.toLowerCase().trim()) ||
                element.phoneNumber!
                    .toLowerCase()
                    .contains(query.toLowerCase().trim()))
            .toList();
      }

      notifyListeners();
      return filteredItems;
    } catch (e) {
      log('Error in search: $e');
    }
    return [];
  }
}
