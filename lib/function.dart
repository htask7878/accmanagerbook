import 'dart:convert';
import 'dart:developer';

import 'package:accmanagerbook/model.dart';

import 'package:http/http.dart' as http;

insertdata() async {
  String name = "";
  name = model.t1.text;
  var url = Uri.parse(
      'https://pdfile7.000webhostapp.com/ac_management/insertdata.php?name=$name');
  var response = await http.get(url);
  log("response = ${response.body}");

  model.t1.clear();
}

//todo insert link --> https://pdfile7.000webhostapp.com/ac_management/insertdata.php?name=hardik
//todo view data link -->https://pdfile7.000webhostapp.com/ac_management/viewdata.php
//todo del.ete data link -->https://pdfile7.000webhostapp.com/ac_management/deletedata.php?id=1
Future viewdata1() async {
  var url =
      Uri.parse('https://pdfile7.000webhostapp.com/ac_management/viewdata1.php');
  var response = await http.get(url);
  log("response = ${response.body}");
  return model.map = jsonDecode(response.body);
}
 viewJoInData() async {
  var url =
  Uri.parse('https://pdfile7.000webhostapp.com/ac_management/viewjoindata.php');
  var response = await http.get(url);
  log("response = ${response.body}");
  return model.map = jsonDecode(response.body);
}

deleteData() async {
  var url = Uri.parse(
      'https://pdfile7.000webhostapp.com/ac_management/deletedata.php?id=');
  var response = await http.get(url);
  log("response = ${response.body}");
  if (response.body == "Delete Data") {
    viewdata1();
  }
}

//todo userAccount function
//('https://pdfile7.000webhostapp.com/ac_management/user_insert.php?')
// user_insert() async {
//   String date = model.dateController.text;
//   String radio=model.type;
//   String amt=model.amtController.text;
//   String par=model.partiController.text;
//
//   var url =
//       Uri.https('pdfile7.000webhostapp.com', 'ac_management/user_insert.php');
//   var response = await http.post(url, body: {''});
//   print("response = ${response.body}");
//
//   model.t1.clear();
// }
// Future user_view() async {
//   var url =
//   Uri.parse('https://pdfile7.000webhostapp.com/ac_management/user_view.php?');
//   var response = await http.get(url);
//   print("response = ${response.body}");
//   return model.map = jsonDecode(response.body);
// }

