import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_dio_d3/Updatepage.dart';
import 'package:project_dio_d3/insertpage.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  Map<String, dynamic> map = {};
  bool status = false;
  model? m;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    try {
      var response =
          await Dio().get('http://workfordemo.in/bunch3/get_address.php');
      print(response);
      map = jsonDecode(response.data);
      m = model.fromJson(map);
      setState(() {
        status = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ALL ADDRESS"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return InsertPage();
              },
            ));
          },
          child: Text("Add"),
        ),
        body: status
            ? ListView.builder(
                itemCount: m!.addressList!.length,
                itemBuilder: (context, index) {
                  int _index = m!.addressList!.length - index - 1;
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Card(
                        elevation: 3,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return UpdatePage(m, _index);
                              },
                            ));
                          },
                          title: Text(
                            "Address :${m!.addressList![_index].addressId}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "addressType :${m!.addressList![_index].addressType}"),
                              Text(
                                  "gps_address :${m!.addressList![_index].gpsAddress}"),
                              Text(
                                  "latitude :${m!.addressList![_index].latitude}"),
                              Text(
                                  "longitude :${m!.addressList![_index].longitude}"),
                              Text("mobile :${m!.addressList![_index].mobile}"),
                              Text("name :${m!.addressList![_index].name}"),
                              Text(
                                  "created :${m!.addressList![_index].created}"),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Delete"),
                                    content: Text(
                                        "Are you sure you want to delete Address"),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            String address_id =
                                                "${m!.addressList![_index].addressId}";
                                            var response = await Dio().get(
                                                'http://workfordemo.in/bunch3/delete_address.php?address_id=$address_id');
                                            Map map = jsonDecode(response.data);
                                            int a = map['success'];
                                            if (a == 1) {
                                              Fluttertoast.showToast(
                                                  msg: "Address deleted",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                getData();
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Address not deleted",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          },
                                          child: Text("Yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("No"))
                                    ],
                                  );
                                },
                                context: context);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class model {
  int? success;
  List<AddressList>? addressList;

  model({this.success, this.addressList});

  model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['address_list'] != null) {
      addressList = <AddressList>[];
      json['address_list'].forEach((v) {
        addressList!.add(new AddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.addressList != null) {
      data['address_list'] = this.addressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressList {
  String? addressId;
  String? addressType;
  String? gpsAddress;
  String? latitude;
  String? longitude;
  String? mobile;
  String? name;
  String? created;

  AddressList(
      {this.addressId,
      this.addressType,
      this.gpsAddress,
      this.latitude,
      this.longitude,
      this.mobile,
      this.name,
      this.created});

  AddressList.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressType = json['address_type'];
    gpsAddress = json['gps_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mobile = json['mobile'];
    name = json['name'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_type'] = this.addressType;
    data['gps_address'] = this.gpsAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['created'] = this.created;
    return data;
  }
}
