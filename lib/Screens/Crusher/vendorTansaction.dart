import 'dart:io';
import 'package:crusher/Model/Transaction.dart';
import 'package:crusher/Provider/Utils.dart';
import 'package:crusher/Service/Network.dart';
import 'package:crusher/Widget/CustomCircular.dart';
import 'package:crusher/Widget/Table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VendorTansaction extends StatefulWidget {
  var id;
   VendorTansaction(this.id) ;

  @override
  VendorTansactionState createState() => VendorTansactionState();
}

class VendorTansactionState extends State<VendorTansaction> {

  List<TransactionVendor> ?transaction;
 int totalWight = 0;


  calltransaction(context, id)async{
    var network = Provider.of<WebServices>(context, listen: false);
    network.getVendorHistoryTransaction(id.toString()).then((value) {
      setState(() {
        transaction = value ;
        for(var v in transaction!){
          totalWight = (totalWight) + (int.parse(v.weight.toString()));
        }
       // result = value;
      });
    });
  }


  @override
  void initState(){
    super.initState();
    calltransaction(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.06,
        child: Center(child: Text('TOTAL WEIGHT: $totalWight', style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold),)),
      ),
      backgroundColor: Color(0xFFFCFFFD),
      body:   ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top:16.0, bottom: 8, left:18),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.keyboard_backspace)),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text('Vendor Transaction', style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:  ElevatedButton(
              child: Text('CONFIRM'),
              onPressed: (){
                var network = Provider.of<WebServices>(context, listen: false);
                circularCustom(context);
                network.approve(context:context,id:widget.id);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                    return Theme.of(context).colorScheme.primary;// Use the component's default.
                  },
                ),
              ),
            )

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
                Container(
                    height:  MediaQuery.of(context).size.height*0.68,
                    child: MyHomePage(data:transaction));


              })

        ],
      ),

    );
  }



}
