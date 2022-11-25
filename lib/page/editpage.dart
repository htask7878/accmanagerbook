import 'dart:convert';

import 'package:accmanagerbook/class/user_entry.dart';
import 'package:accmanagerbook/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class editpage extends StatefulWidget {
  String? id;
  String? name;

  editpage(this.id, this.name);

  @override
  State<editpage> createState() => _editpageState();
}

class _editpageState extends State<editpage> {
  // DateTime current_Date = DateTime(2022, 09, 29);
  // String date = "";
  List userlist = [];
  user_entry? ue;
  int Credit = 0, Debit = 0, Balence = 0;
  Color red = Color(0xffDC2024);
  Color green = Color(0xff21b389);
  TextEditingController up_date = TextEditingController();
  TextEditingController up_amt = TextEditingController();
  TextEditingController up_part = TextEditingController();
  String type1 = "";

  Future user_view() async {
    var url = Uri.parse(
        'https://pdfile7.000webhostapp.com/ac_management/user_view.php?id=${widget.id}');
    var response = await http.get(url);
    print("response = ${response.body}");
    return userlist = jsonDecode(response.body);
  }

  method() async {
    var url = Uri.parse(
        'https://pdfile7.000webhostapp.com/ac_management/user_view.php?id=${widget.id}');
    var response = await http.get(url);
    print("response = ${response.body}");
    userlist = jsonDecode(response.body);
    userlist.forEach((element) {
      user_entry u = user_entry.fromJson(element);

      if (u.type == "credit") {
        Credit = Credit + int.parse("${u.amount}");
      }
      if (u.type == "debit") {
        Debit = Debit + int.parse("${u.amount}");
      }
      Balence = Credit - Debit;
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    method();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("${widget.name}"),
            backgroundColor: model.bluecolor,
            actions: [
              IconButton(
                  onPressed: () {
                    add_data();
                  },
                  icon: Icon(Icons.save_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(child: Text("Save as PDF")),
                  PopupMenuItem(child: Text("Save as Excel")),
                  PopupMenuItem(child: Text("Share the app")),
                  PopupMenuItem(child: Text("Rate the app")),
                ],
              )
            ]),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ColoredBox(
                  child: Center(
                    child: Text(
                      "Creadit(↑)\n₹$Credit",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  color: Color(0xfff8f3f7),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  child: Center(
                    child: Text(
                      "Debit(↓)\n₹$Debit",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  color: Color(0xffe5e3e6),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  child: Center(
                      child: Text(
                    "Balence\n₹$Balence",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: model.whitecolor),
                  )),
                  color: model.bluecolor,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 32,
              width: double.infinity,
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                        "Dete"),
                  ),
                  Expanded(
                    child: Text(
                        textAlign: TextAlign.center,
                        "Particular",
                        style: TextStyle(fontSize: 15)),
                  ),
                  Expanded(
                    child: Text(
                        textAlign: TextAlign.center,
                        "Amount",
                        style: TextStyle(fontSize: 15)),
                  ),
                  Expanded(
                    child: Text(
                        textAlign: TextAlign.center,
                        "Type",
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: user_view(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: userlist.length,
                    itemBuilder: (context, index) {
                      ue = user_entry.fromJson(userlist[index]);
                      if (index % 2 == 1) {
                        return datalist(Color(0xfff2f2f2));
                      } else {
                        return datalist(Color(0xffffffff));
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  datalist(Color c) {
    return Ink(
      height: 30,
      color: c,
      child: InkWell(
        onTap: () {
          PopupMenuButton(
              color: Colors.green,
              child: Text("Hardik"),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 1,
                        onTap: () {
                          update_data();
                          Navigator.pop(context);
                        },
                        child: Text("Edit")),
                    PopupMenuItem(
                        value: 2,
                        onTap: () {
                          print("Hardik");
                          showDialog(
                            // useSafeArea: true,
                            context: context,
                            builder: (context) {
                              print("Utsav");
                              return SimpleDialog(
                                title: Text(
                                  "Are you sure?",
                                ),
                                children: [
                                  Center(
                                      child: Text(
                                          textAlign: TextAlign.start,
                                          "You want to  delete this transaction")),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "CANCEL",
                                            style: TextStyle(
                                                color: model.orangecolor),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            var url = Uri.parse(
                                                'https://pdfile7.000webhostapp.com/ac_management/user_delete.php?id=${ue!.id}');
                                            var response = await http.get(url);
                                            print(
                                                "response = ${response.body}");
                                            if (response.body.trim() ==
                                                "Delete Data") {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          editpage(widget.id,
                                                              widget.name)));
                                            }
                                          },
                                          child: Text(
                                            "DELETE",
                                            style: TextStyle(
                                                color: model.orangecolor),
                                          )),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                          Navigator.pop(context);
                        },
                        child: Text("Delete")),
                  ]);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Text(
                    style: TextStyle(
                        fontSize: 14,
                        color: (ue!.type == "credit") ? green : red),
                    textAlign: TextAlign.center,
                    "${ue!.date}")),
            Expanded(
                child: Text(
                    style: TextStyle(
                        fontSize: 14,
                        color: (ue!.type == "credit") ? green : red),
                    textAlign: TextAlign.center,
                    "${ue!.particular}")),
            Expanded(
                child: Text(
                    style: TextStyle(
                        fontSize: 14,
                        color: (ue!.type == "credit") ? green : red),
                    textAlign: TextAlign.center,
                    "${ue!.amount}")),
            Expanded(
                child: Text(
                    style: TextStyle(
                        fontSize: 14,
                        color: (ue!.type == "credit") ? green : red),
                    textAlign: TextAlign.center,
                    "${ue!.type}")),
          ],
        ),
      ),
    );
  }

  add_data() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState1) {
            return Dialog(
              child: SizedBox(
                height: 320,
                child: Column(children: [
                  Ink(
                    color: model.bluecolor,
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text("Add transaction",
                          style:
                              TextStyle(color: model.whitecolor, fontSize: 17)),
                    ),
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: "Enter transeation date"),
                    controller: model.datecontroller,
                    // onTap: () {
                    //    showDatePicker(
                    //      // currentDate: DateTime.now(),
                    //       context: context,
                    //       initialDate: current_Date,
                    //       firstDate: DateTime(1990),
                    //       lastDate: DateTime(2100));
                    //   // print(newdate);
                    //   setState(() {
                    //     date = current_Date.toString();
                    //   });
                    //   },
                    cursorColor: model.orangecolor,
                    style: TextStyle(color: model.bluecolor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Teansection type:", style: TextStyle(fontSize: 10)),
                      Radio(
                        value: "credit",
                        groupValue: model.type,
                        onChanged: (value) {
                          setState1(() {
                            model.type = value.toString();
                            print("${model.type}");
                          });
                        },
                      ),
                      Text("Credit", style: TextStyle(fontSize: 13)),
                      Radio(
                        value: "debit",
                        groupValue: model.type,
                        onChanged: (value) {
                          setState1(() {
                            model.type = value.toString();
                            print("${model.type}");
                          });
                        },
                      ),
                      Text("Debit", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    cursorHeight: 25,
                    cursorColor: model.orangecolor,
                    style: TextStyle(color: model.bluecolor),
                    controller: model.particontroller,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: model.orangecolor, width: 2)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: model.orangecolor)),
                      labelStyle: TextStyle(color: model.orangecolor),
                    ),
                  ),
                  TextField(
                    cursorHeight: 25,
                    cursorColor: model.orangecolor,
                    style: TextStyle(color: model.bluecolor),
                    controller: model.amtcontroller,
                    decoration: InputDecoration(
                        hintText: "Particular",
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: model.orangecolor, width: 2)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: model.orangecolor)),
                        labelStyle: TextStyle(color: model.orangecolor),
                        fillColor: model.orangecolor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: model.bluecolor,
                              fixedSize: Size(120, 35),
                              side: BorderSide(color: model.bluecolor),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: model.bluecolor),
                          )),
                      //TODO save
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: model.whitecolor,
                              backgroundColor: model.bluecolor,
                              fixedSize: Size(120, 35),
                              side: BorderSide(color: model.bluecolor),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)))),
                          onPressed: () async {
                            String date = model.datecontroller.text;
                            String radio = model.type;
                            String amt = model.amtcontroller.text;
                            String par = model.particontroller.text;

                            var url = Uri.https('pdfile7.000webhostapp.com',
                                'ac_management/user_insert.php');
                            var response = await http.post(url, body: {
                              'date': date,
                              'type': radio,
                              'amount': amt,
                              'particular': par,
                              'cl_id': widget.id,
                            });

                            print("response = ${response.body}");
                            if (response.body == "data insert") {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return editpage(widget.id, widget.name);
                                },
                              ));
                            }
                            model.datecontroller.clear();
                            model.type = "";
                            model.amtcontroller.clear();
                            model.particontroller.clear();
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(color: model.whitecolor),
                          )),
                    ],
                  ),
                ]),
              ),
            );
          },
        );
      },
    );
  }

  update_data() {
    return showDialog(
      context: context,
      builder: (context) {
        up_date.text = ue!.date!;
        type1 = model.type.toString();
        up_amt.text = ue!.amount!;
        up_part.text = ue!.particular!;
        // up_part
        return StatefulBuilder(
          builder: (context, setState1) {
            return Dialog(
              child: SizedBox(
                height: 320,
                child: Column(children: [
                  Ink(
                    color: model.bluecolor,
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text("Update transaction",
                          style:
                              TextStyle(color: model.whitecolor, fontSize: 17)),
                    ),
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: "Enter transeation date"),
                    controller: up_date,
                    // onTap: () {
                    //    showDatePicker(
                    //      // currentDate: DateTime.now(),
                    //       context: context,
                    //       initialDate: current_Date,
                    //       firstDate: DateTime(1990),
                    //       lastDate: DateTime(2100));
                    //   // print(newdate);
                    //   setState(() {
                    //     date = current_Date.toString();
                    //   });
                    //   },
                    cursorColor: model.orangecolor,
                    style: TextStyle(color: model.bluecolor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Teansection type:", style: TextStyle(fontSize: 10)),
                      Radio(
                        value: "credit",
                        fillColor: MaterialStateProperty.all(model.orangecolor),
                        groupValue: type1,
                        onChanged: (value) {
                          setState1(() {
                            type1 = value.toString();
                            print("${type1}");
                          });
                        },
                      ),
                      Text("Credit", style: TextStyle(fontSize: 13)),
                      Radio(
                        value: "debit",
                        fillColor: MaterialStateProperty.all(model.orangecolor),
                        groupValue: type1,
                        onChanged: (value) {
                          setState1(() {
                            type1 = value.toString();
                            print("${type1}");
                          });
                        },
                      ),
                      Text("Debit", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    cursorHeight: 25,
                    cursorColor: model.orangecolor,
                    style: TextStyle(color: model.bluecolor),
                    controller: up_amt,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: model.orangecolor, width: 2)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: model.orangecolor)),
                      labelStyle: TextStyle(color: model.orangecolor),
                    ),
                  ),
                  TextField(
                    cursorHeight: 25,
                    cursorColor: model.orangecolor,
                    style: TextStyle(color: model.bluecolor),
                    controller: up_part,
                    decoration: InputDecoration(
                        hintText: "Particular",
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: model.orangecolor, width: 2)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: model.orangecolor)),
                        labelStyle: TextStyle(color: model.orangecolor),
                        fillColor: model.orangecolor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: model.bluecolor,
                              fixedSize: Size(120, 35),
                              side: BorderSide(color: model.bluecolor),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: model.bluecolor),
                          )),
                      //TODO save
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: model.whitecolor,
                              backgroundColor: model.bluecolor,
                              fixedSize: Size(120, 35),
                              side: BorderSide(color: model.bluecolor),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)))),
                          onPressed: () async {
                            var url = Uri.https('pdfile7.000webhostapp.com',
                                'ac_management/user_update.php');
                            var response = await http.post(url, body: {
                              'date': up_date.text,
                              'type': type1.toString(),
                              'amount': up_amt.text,
                              'particular': up_part.text,
                            });

                            print("response = ${response.body}");
                            if (response.body == "Data is Update") {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return editpage(widget.id, widget.name);
                                },
                              ));
                            }
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(color: model.whitecolor),
                          )),
                    ],
                  ),
                ]),
              ),
            );
          },
        );
      },
    );
  }
}
