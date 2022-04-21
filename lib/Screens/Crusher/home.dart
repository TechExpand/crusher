import 'dart:io';
import 'package:crusher/Model/Transaction.dart';
import 'package:crusher/Provider/Utils.dart';
import 'package:crusher/Screens/Crusher/vendorTansaction.dart';
import 'package:crusher/Service/Network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<Home> {

  List<Transaction> ?transaction;



  calltransaction(context)async{
    var network = Provider.of<WebServices>(context, listen: false);
    network.getUserTransaction().then((value) {
      setState(() {
        transaction = value ;
        result = value;
      });
    });
  }


  @override
  void initState(){
    super.initState();
    calltransaction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFFFD),
      body:   ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:16.0, bottom: 8, left:18),
                    child: Text('All Vendors', style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child:  InkWell(
                      onTap: (){
                        dialogPage(context);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 12),
                        margin: const EdgeInsets.only(bottom: 15, top: 15),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            border: Border.all(color: Color(0xFFF1F1FD)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54.withOpacity(0.1),
                                  blurRadius: 15.0,
                                  offset: Offset(0.3, 1.0))
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                FeatherIcons.search,
                                color: Color(0xFF555555),
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                autofocus: false,
                                enabled:false,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF270F33),
                                    fontWeight: FontWeight.w600),
                                onChanged: (text) {

                                  },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Find vendors by email',
                                  hintStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                  focusColor: Color(0xFF2B1137),
                                  fillColor: Color(0xFF2B1137),
                                  hoverColor: Color(0xFF2B1137),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Builder(
                      builder: (context) {
                        return transaction == null ? Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Theme(
                                data: Theme.of(context).copyWith(
                                  accentColor: Color(0xFF00A85A),),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF00A85A)),
                                  strokeWidth: 2,
                                  backgroundColor: Colors.white,
                                  //  valueColor: new AlwaysStoppedAnimation<Color>(color: Color(0xFF9B049B)),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Loading',
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ],
                        )) : transaction!.isEmpty ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("No Transaction Available", style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                height: 1.4,
                                fontWeight: FontWeight.w500)),),
                          ],
                        ) :
ListView.builder(
  shrinkWrap: true,
  physics: ScrollPhysics(),
  itemCount: transaction!.length,
  itemBuilder: (context, index) {
    return     Card(
      child: ListTile(
        onTap: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return VendorTansaction(transaction![index].id.toString()); //SignUpAddress();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        trailing: Text(transaction![index].user['id'].toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold),),
         title: Text(transaction![index].user['email'].toString(),
           style: TextStyle(
               fontWeight: FontWeight.bold),),
        subtitle: Text(transaction![index].user['username'].toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold),),
      ),
    );
  }
);


                      })

                ],
              ),

    );
  }

  List result = [];

  dialogPage(ctx) {
    result = transaction!;
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
              return AlertDialog(
                title: TextFormField(
                  onChanged: (value) {
                    if(value.isEmpty){
                      setStates((){
                        result = transaction!;
                      });
                    }else{
                      setStates((){
                        searchServices(value);
                      });
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Search Vendors',
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(new Radius.circular(50.0)),
                  ),
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 500,
                          child: ListView.builder(
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return VendorTansaction(result[index].id.toString()); //SignUpAddress();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text('${result[index].user['email'].toString()}'),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).then((v) {
      setState(() {});
    });
  }

  void searchServices(userInputValue){
    result = result
        .where((user) => user.user['email'].toString()
        .toLowerCase()
        .contains(userInputValue.toLowerCase()))
        .toList();
  }


}
