import 'package:accmanagerbook/class/client.dart';
import 'package:accmanagerbook/page/editpage.dart';
import 'package:accmanagerbook/function.dart';
import 'package:accmanagerbook/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewJoInData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Color(0xffdfdfdf),
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Column(
                        children: [
                          Ink(
                            color: model.bluecolor,
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text("Select account",
                                  style: TextStyle(
                                      color: model.whiteColor, fontSize: 17)),
                            ),
                          ),
                          Ink(
                            color: model.whiteColor,
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: TextField(
                                  controller: model.search_controller,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: "Search account",
                                  ),
                                  style: TextStyle(
                                      color: model.whiteColor, fontSize: 17)),
                            ),
                          ),
                          Expanded(
                              child: Ink(
                            color: Color(0xfff2f2f2),
                          )),
                          Ink(
                            color: model.whiteColor,
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: model.bluecolor,
                                        fixedSize: Size(120, 35),
                                        side:
                                            BorderSide(color: model.bluecolor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)))),
                                    onPressed: () {
                                      model.search_controller.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "CANCEL",
                                      style: TextStyle(color: model.bluecolor),
                                    )),
                                //TODO
                                TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: model.whiteColor,
                                        backgroundColor: model.bluecolor,
                                        fixedSize: Size(120, 35),
                                        side:
                                            BorderSide(color: model.bluecolor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)))),
                                    onPressed: () {
                                      // Navigator.pushReplacement(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return first();
                                      //   },
                                      // ));
                                      // setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "SAVE",
                                      style: TextStyle(color: model.whiteColor),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Save as PDF"),
              ),
              PopupMenuItem(child: Text("Save as Excel")),
            ],
          )
        ], backgroundColor: model.bluecolor, title: Text("Dashboard")),
        drawer: Drawer(width: 250),
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: Image(
              image: AssetImage("image/add.png"),
              width: 30,
              color: Colors.white),
          backgroundColor: model.orangeColor,
          onPressed: () {
            dailog_box();
          },
        ),
        body: FutureBuilder(
          future: viewdata1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List? list = model.map;
              return list!.isEmpty
                  ? Container(
                      color: Colors.white,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning,
                              color: Color(0xffdd536c), size: 100),
                          Text("NO ACCOUNT ADDED",
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 17)),
                          Text(
                            "Click on add button to add your account",
                            style: TextStyle(
                                color: Colors.grey[300], fontSize: 15),
                          )
                        ],
                      )),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 6, left: 6),
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          client cl = client.fromJson(list[index]);
                          // model.cid = cl.name!;
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return editPage(cl.id, cl.name);
                                },
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              margin: EdgeInsets.only(top: 9, bottom: 9),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text("${cl.name}",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Container(
                                      height: 37,
                                      width: 37,
                                      margin: EdgeInsets.only(
                                          top: 2, bottom: 2, left: 4, right: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffE0E0E0),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: IconButton(
                                        onPressed: () {
                                          editingController.text = cl.name!;
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: SizedBox(
                                                  height: 200,
                                                  child: Column(children: [
                                                    Ink(
                                                      color: model.bluecolor,
                                                      height: 50,
                                                      width: double.infinity,
                                                      child: Center(
                                                        child: Text(
                                                            "Add new account",
                                                            style: TextStyle(
                                                                color: model
                                                                    .whiteColor,
                                                                fontSize: 17)),
                                                      ),
                                                    ),
                                                    TextField(
                                                      cursorHeight: 30,
                                                      cursorColor:
                                                          model.orangeColor,
                                                      style: TextStyle(
                                                          color:
                                                              model.bluecolor),
                                                      controller:
                                                          editingController,
                                                      decoration: InputDecoration(
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: model
                                                                          .orangeColor,
                                                                      width:
                                                                          2)),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: model
                                                                          .orangeColor)),
                                                          labelText:
                                                              "Account name",
                                                          labelStyle: TextStyle(
                                                              color: model
                                                                  .orangeColor),
                                                          fillColor: model
                                                              .orangeColor),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        TextButton(
                                                            style: TextButton.styleFrom(
                                                                foregroundColor:
                                                                    model
                                                                        .bluecolor,
                                                                fixedSize: Size(
                                                                    120, 35),
                                                                side: BorderSide(
                                                                    color: model
                                                                        .bluecolor),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(40)))),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              "CANCEL",
                                                              style: TextStyle(
                                                                  color: model
                                                                      .bluecolor),
                                                            )),
                                                        //TODO update data
                                                        TextButton(
                                                            style: TextButton.styleFrom(
                                                                foregroundColor:
                                                                    model
                                                                        .whiteColor,
                                                                backgroundColor:
                                                                    model
                                                                        .bluecolor,
                                                                fixedSize: Size(
                                                                    120, 35),
                                                                side: BorderSide(
                                                                    color: model
                                                                        .bluecolor),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            40)))),
                                                            onPressed:
                                                                () async {
                                                              // editingController.text=model.t1.text;
                                                              var url = Uri.parse(
                                                                  'https://pdfile7.000webhostapp.com/ac_management/updatedata.php?id=${cl.id}&name=${editingController.text}');
                                                              var response =
                                                                  await http
                                                                      .get(url);
                                                              print(
                                                                  "response = ${response.body}");
                                                              // editingController.clear();
                                                              if (response.body
                                                                      .trim() ==
                                                                  "Data is Update") {
                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return first();
                                                                  },
                                                                ));
                                                              }
                                                            },
                                                            child: Text(
                                                              "UPDATE",
                                                              style: TextStyle(
                                                                  color: model
                                                                      .whiteColor),
                                                            )),
                                                      ],
                                                    ),
                                                  ]),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: ImageIcon(
                                            size: 25,
                                            AssetImage("image/update.png"),
                                            color: model.bluecolor),
                                      ),
                                    ),
                                    Container(
                                      height: 37,
                                      width: 37,
                                      margin: EdgeInsets.only(
                                          top: 2, bottom: 2, left: 4, right: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffE0E0E0),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                title: Text(
                                                  "Are you sure?",
                                                  style: TextStyle(
                                                      color: model.bluecolor),
                                                ),
                                                children: [
                                                  Center(
                                                      child: Text(
                                                          textAlign:
                                                              TextAlign.start,
                                                          "You want to  delete account")),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "CANCEL",
                                                            style: TextStyle(
                                                                color: model
                                                                    .orangeColor),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            var url = Uri.parse(
                                                                'https://pdfile7.000webhostapp.com/ac_management/deletedata.php?id=${cl.id}');
                                                            var response =
                                                                await http
                                                                    .get(url);
                                                            print(
                                                                "response = ${response.body}");
                                                            if (response.body
                                                                    .trim() ==
                                                                "Delete Data") {
                                                              Navigator
                                                                  .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                first(),
                                                                      ));
                                                            }
                                                          },
                                                          child: Text(
                                                            "DELETE",
                                                            style: TextStyle(
                                                                color: model
                                                                    .orangeColor),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: ImageIcon(
                                            size: 25,
                                            AssetImage("image/delete.png"),
                                            color: model.bluecolor),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 105,
                                      child: Center(
                                        child: Text(
                                          "Credit(↑)\n₹",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xfff8f3f7),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                    ),
                                    Container(
                                      height: 70,
                                      width: 105,
                                      child: Center(
                                        child: Text(
                                          "Debit(↓)\n₹0",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xffe5e3e6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                    ),
                                    Container(
                                      height: 70,
                                      width: 105,
                                      child: Center(
                                          child: Text(
                                        "Balance\n₹0",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: model.whiteColor),
                                      )),
                                      decoration: BoxDecoration(
                                          color: model.bluecolor,
                                          // border: Border.all(color: Colors.cyan),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(
                    color: model.bluecolor, strokeWidth: 2),
              );
            }
          },
        ),
      ),
    );
  }

  dailog_box() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 200,
            child: Column(children: [
              Ink(
                color: model.bluecolor,
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text("Add new account",
                      style: TextStyle(color: model.whiteColor, fontSize: 17)),
                ),
              ),
              TextField(
                cursorHeight: 30,
                cursorColor: model.orangeColor,
                style: TextStyle(color: model.bluecolor),
                controller: model.t1,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: model.orangeColor, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: model.orangeColor)),
                    labelText: "Account name",
                    labelStyle: TextStyle(color: model.orangeColor),
                    fillColor: model.orangeColor),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: model.bluecolor,
                          fixedSize: Size(120, 35),
                          side: BorderSide(color: model.bluecolor),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)))),
                      onPressed: () {
                        model.t1.clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: model.bluecolor),
                      )),
                  //TODO save data
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: model.whiteColor,
                          backgroundColor: model.bluecolor,
                          fixedSize: Size(120, 35),
                          side: BorderSide(color: model.bluecolor),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)))),
                      onPressed: () async {
                        String name = "";
                        name = model.t1.text;
                        var url = Uri.parse(
                            'https://pdfile7.000webhostapp.com/ac_management/insertdata.php?name=$name');
                        var response = await http.get(url);
                        print("response = ${response.body}");
                        model.t1.clear();
                        if (response.body.trim() == "data insert") {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return first();
                            },
                          ));
                        }
                      },
                      child: Text(
                        "SAVE",
                        style: TextStyle(color: model.whiteColor),
                      )),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
