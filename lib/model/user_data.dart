class UserDataModel {
  String? phoneNumber;
  String? adress;
  String? remark;
  String? industry;
  String? visitedTime;
  String? status;
  String? name;
  String? requirment;

  UserDataModel(
      {this.phoneNumber,
      this.adress,
      this.remark,
      this.industry,
      this.visitedTime,
      this.status,
      this.name,
      this.requirment});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    adress = json['adress'];
    remark = json['remark'];
    industry = json['Industry'];
    visitedTime = json['visited_time'];
    status = json['status'];
    name = json['name'];
    requirment = json['requirment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['phone_number'] = phoneNumber;
    data['adress'] = adress;
    data['remark'] = remark;
    data['Industry'] = industry;
    data['visited_time'] = visitedTime;
    data['status'] = status;
    data['name'] = name;
    data['requirment'] = requirment;
    return data;
  }
}

