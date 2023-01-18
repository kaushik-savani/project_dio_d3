import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_dio_d3/ViewPage.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  String address1 = '';
  String adtype = 'home';
  Color bhome = Colors.black54;
  Color boffice = Colors.white;
  Color bother = Colors.white;
  Color thome = Colors.white;
  Color toffice = Colors.black;
  Color tother = Colors.black;
  TextEditingController tmno = TextEditingController();
  TextEditingController tname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mwidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black54),
                    child: Text("ADD ADDRESS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade200),
                    child: DropdownButtonFormField(
                      alignment: Alignment.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      hint: Text(
                        "Surat Gujarat",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      onChanged: (value) {
                        setState(() {
                          address1 = value.toString();
                        });
                      },
                      items: [
                        DropdownMenuItem(
                            value: "Varachha", child: Text("Varachha")),
                        DropdownMenuItem(value: "Udhna", child: Text("Udhna")),
                        DropdownMenuItem(value: "Kamrej", child: Text("Kamrej"))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Address Type:",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 35,
                        width: mwidth * .3,
                        alignment: Alignment.center,
                        decoration:
                            BoxDecoration(border: Border.all(), color: bhome),
                        child: InkWell(
                          onTap: () {
                            bhome = Colors.black54;
                            boffice = Colors.white;
                            bother = Colors.white;
                            thome = Colors.white;
                            toffice = Colors.black;
                            tother = Colors.black;
                            adtype = "Home";
                            setState(() {});
                          },
                          child: Text(
                            "Home",
                            style: TextStyle(color: thome, fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: mwidth * .3,
                        alignment: Alignment.center,
                        decoration:
                            BoxDecoration(border: Border.all(), color: boffice),
                        child: InkWell(
                          onTap: () {
                            bhome = Colors.white;
                            boffice = Colors.black54;
                            bother = Colors.white;
                            toffice = Colors.white;
                            thome = Colors.black;
                            tother = Colors.black;
                            adtype = "Office";
                            setState(() {});
                          },
                          child: Text(
                            "Office",
                            style: TextStyle(color: toffice, fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: mwidth * .3,
                        alignment: Alignment.center,
                        decoration:
                            BoxDecoration(border: Border.all(), color: bother),
                        child: InkWell(
                          onTap: () {
                            boffice = Colors.white;
                            bhome = Colors.white;
                            bother = Colors.black54;
                            tother = Colors.white;
                            toffice = Colors.black;
                            thome = Colors.black;
                            adtype = "Other";
                            setState(() {});
                          },
                          child: Text(
                            "Other",
                            style: TextStyle(color: tother, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Mobile No:",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        controller: tmno,
                        onTap: () {},
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300)),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Name:",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        keyboardType: TextInputType.name,
                        controller: tname,
                        onTap: () {},
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: mwidth * .5,
                        child: ElevatedButton(
                          onPressed: () async {
                            String gps_address = address1;
                            String address_type = adtype;
                            String mobile = tmno.text;
                            String name = tname.text;
                            var response = await Dio().get(
                                'http://workfordemo.in/bunch3/insert_address.php?gps_address=$gps_address'
                                '%20road,%20surat&latitude=21.84444&longitude=72.54445&address_type='
                                '$address_type&mobile=$mobile&name=$name');
                            print(response.data);
                            Map m = jsonDecode(response.data);
                            int success = m['success'];
                            if (success == 1) {
                              Fluttertoast.showToast(
                                  msg: "Address Saved",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.transparent,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return ViewPage();
                                },
                              ));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Address not Saved",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.transparent,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text("Submit"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black54,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: goback);
  }

  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return ViewPage();
      },
    ));
    return Future.value();
  }
}
