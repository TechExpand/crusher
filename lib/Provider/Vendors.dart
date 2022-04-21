//
// import 'package:flutter/material.dart';
//
// class PostRequestProvider with ChangeNotifier {
//   PostRequestProvider() {
//     getServices();
//   }
//   bool gotit = true;
//   changeGotit() {
//     gotit = false;
//     notifyListeners();
//   }
//
//
//
//
//   Future<dynamic> getServices() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String bearer = prefs.getString('Bearer');
//     String userId = prefs.getString('user_id');
//     //var data = Provider.of<DataProvider>(context, listen: false);
//     try {
//       var response = await http
//           .post(Uri.parse('https://manager.fixme.ng/service-list'), body: {
//         'user_id': userId,
//       }, headers: {
//         // "Content-type": "application/json",
//         //"Content-type": "application/x-www-form-urlencoded",
//         'Authorization': 'Bearer $bearer',
//       });
//       // var statusCode = response.statusCode;
//       var body1 = json.decode(response.body);
//       List body = body1['services'];
//       // user_id = body['id'];
//       List<Services> serviceListz = body
//           .map((data) {
//         return Services.fromJson(data);
//       })
//           .toSet()
//           .toList();
//       servicesList = serviceListz;
//       notifyListeners();
//     } catch (e) {
//       // Login_SetState();
//       print(e);
//       print('na error b tat');
//     }
//     //isLoading(false);
//   }
//
//   Future<dynamic> getAllServices() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String bearer = prefs.getString('Bearer');
//     String userId = prefs.getString('user_id');
//     //var data = Provider.of<DataProvider>(context, listen: false);
//     try {
//       var response = await http
//           .post(Uri.parse('https://manager.fixme.ng/service-list'), body: {
//         'user_id': userId,
//       }, headers: {
//         // "Content-type": "application/json",
//         //"Content-type": "application/x-www-form-urlencoded",
//         'Authorization': 'Bearer $bearer',
//       });
//       // var statusCode = response.statusCode;
//       var body1 = json.decode(response.body);
//       List body = body1['services'];
//       // user_id = body['id'];
//
//       List<Services> serviceLists = body.map((data) {
//         return Services.fromJson(data);
//       }).toList();
//       allservicesList = serviceLists;
//       print(allservicesList);
//       notifyListeners();
//     } catch (e) {
//       // Login_SetState();
//       print(e);
//       print('na error b tat');
//     }
//   }
//
//   changeService(Services services) {
//     selectedService = services;
//     print(selectedService.service);
//     notifyListeners();
//   }
//
//   changeSelectedService(Services services) {
//     selecteService = services;
//     notifyListeners();
//   }
// }
