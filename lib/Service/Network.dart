import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crusher/Model/Transaction.dart';
import 'package:crusher/Screens/Crusher/home.dart';
import 'package:crusher/Screens/Crusher/vendorTansaction.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WebServices extends ChangeNotifier {
  String username = "";
  String myemail = "";
  String myphonenumber = "";
  String wallet = "";
  dynamic points;
  dynamic walletpoints;
  int id = 0;
  String token = "";
  String image = '';
  String editname = "";
  String editphone = "";
  String userType = '';
  final box = GetStorage();
  var path = '';



  setPath(value){
    path = value;
    notifyListeners();
  }

  setUserType(value){
    userType = value;
    notifyListeners();
  }


  setToken(value){
    token = value;
    notifyListeners();
  }


  //
  // Future<dynamic> sendTransaction(category, weight, userId, context)async{
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'https://frankediku.pythonanywhere.com/vendorsapi/userdetails/${userId.toString()}/${weight.toString()}/'),
  //         body: jsonEncode(<String, String>{
  //           'weight': weight.toString(),
  //           'category': category.toString(),
  //           'id': userId.toString(),
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //            'Authorization': 'Token $token',
  //         });
  //
  //     var body = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 ||
  //         response.statusCode == 201 ||
  //         response.statusCode == 202) {
  //       print('gooodddd');
  //       Navigator.pop(context);
  //      sendDialog(context, agent: 'agent');
  //     } else {
  //       print(body);
  //       Navigator.pop(context);
  //       await showTextToast(
  //           text: 'unable to create transaction.',
  //           context: context,
  //       );
  //     }
  //   } catch (e) {
  //     print('wronggg');
  //     Navigator.pop(context);
  //     await showTextToast(
  //       text: 'a problem has occured. try again',
  //       context: context,
  //     );
  //   }
  // }





  //
  //
  // Future<dynamic> getAccountName(bankCode, accountNumber, context)async{
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'https://api.flutterwave.com/v3/accounts/resolve'),
  //         body: jsonEncode(<String, String>{
  //           'account_number': accountNumber.toString(),
  //           'account_bank': bankCode.toString(),
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'Authorization': 'Bearer FLWSECK-71230ccbd14863ff68afb87741acdbec-X',
  //
  //         });
  //     print(response.body);
  //     var body = jsonDecode(response.body);
  //     if (response.statusCode >= 200) {
  //       if(body['status'] == 'success'){
  //         Navigator.pop(context);
  //          showTextToast(
  //           text: body['message'].toString(),
  //           context: context,
  //         );
  //         return  body['data']['account_name'];
  //       }else{
  //         Navigator.pop(context);
  //          showTextToast(
  //           text: body['message'].toString(),
  //           context: context,
  //         );
  //         return 'error';
  //       }
  //
  //     } else {
  //       var body = jsonDecode(response.body);
  //       Navigator.pop(context);
  //       await showTextToast(
  //         text: body['message'].toString(),
  //         context: context,
  //       );
  //
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     await showTextToast(
  //       text: 'a problem has occured. try again',
  //       context: context,
  //     );
  //   }
  // }




  Future<dynamic> LoginUser({context, email, password}) async {
    try {
      var response = await http.post(
          Uri.parse('https://frankediku.pythonanywhere.com/crusherapi/login/'),
          body: jsonEncode(<String, String>{
            'email': email.toString(),
            'password': password.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //  'Authorization': 'Bearer $bearer',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print(response.body);
        print(response.body);

        username = body['fullname'];
        myemail = body['email'];
        myphonenumber = body['phonenumber'];
        wallet = body['wallet'];
        points = body['weight'];
        walletpoints = body['walletpoints'];
        token = body['token'];
        id = body['id'];
        box.write('token', token);
        box.write('type', 'user');

        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return Home();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      } else if (body['message']['user'] == 'Invalid Login Details') {
        print('mamamama');
        Navigator.pop(context);
        await showTextToast(
          text: 'Invalid Login Details.',
          context: context,
        );
      } else {
        print('lalallala');
        Navigator.pop(context);
        await showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      print('jaaa');
      Navigator.pop(context);
      print(e);
    }
  }



  Future getUserTransaction() async {
    try{
      var response = await http.get(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/crusherapi/filteragent/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          }).timeout(Duration(seconds: 20));
      var body = json.decode(response.body);
      print(response.body.toString()+'lllllllll');
      print('hhhshs');
      List body1 = body;
      List<Transaction> UsertransLists = body1.map((data) {
        return Transaction.fromJson(data);
      }).toList();

      notifyListeners();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        if (UsertransLists.isEmpty) {
          List<Transaction> defaul = [];
          return defaul;
        } else {
          print(UsertransLists);
          return UsertransLists;
        }
      } else {
        print('failed');
      }
    }on TimeoutException catch (e) {
      List<Transaction> defaul = [
        Transaction(amount: 'network')
      ];
      return defaul;
    } on SocketException catch (e) {
      List<Transaction> defaul = [
        Transaction(amount: 'network')
      ];
      print('Socket Error: $e');
      return defaul;
    } on Error catch (e) {
      List<Transaction> defaul = [
        Transaction(amount: 'network')
      ];
      print('General Error: $e');
      return defaul;
    }

  }


  Future<dynamic> approve({context,id}) async {
    try {
      var response = await http.get(
          Uri.parse('https://frankediku.pythonanywhere.com/crusherapi/approvetransaction/?id=${id.toString()}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          });

      var body = jsonDecode(response.body);
      print(response.body);
      print(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print(response.body);
        print(response.body);

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return VendorTansaction(id);
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
        await showTextToast(
          text: 'Approved.',
          context: context,
        );
      } else {
        print('lalallala');
        Navigator.pop(context);
        await showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      print('jaaa');
      Navigator.pop(context);
      print(e);
    }
  }


  //https://frankediku.pythonanywhere.com/crusherapi/approvetransaction/?id=273

  Future getVendorHistoryTransaction(id) async {
    try{
      var response = await http.get(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/crusherapi/transactionhistory/?id=$id'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          }).timeout(Duration(seconds: 20));
      var body = json.decode(response.body);
      List body1 = body;
      List<TransactionVendor> UsertransLists = body1.map((data) {
        return TransactionVendor.fromJson(data);
      }).toList();

      notifyListeners();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        if (UsertransLists.isEmpty) {
          List<TransactionVendor> defaul = [];
          return defaul;
        } else {
          print(UsertransLists[0].id);
          return UsertransLists;
        }
      } else {
        print('failed');
      }
    }on TimeoutException catch (e) {
      List<TransactionVendor> defaul = [
        TransactionVendor(amount: 'network')
      ];
      return defaul;
    } on SocketException catch (e) {
      List<TransactionVendor> defaul = [
        TransactionVendor(amount: 'network')
      ];
      print('Socket Error: $e');
      return defaul;
    } on Error catch (e) {
      List<TransactionVendor> defaul = [
        TransactionVendor(amount: 'network')
      ];
      print('General Error: $e');
      return defaul;
    }

  }



}


class NetworkError{
  String network;
  NetworkError({required this.network});
}
