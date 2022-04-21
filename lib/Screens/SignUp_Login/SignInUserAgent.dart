import 'package:crusher/Provider/Provider.dart';
import 'package:crusher/Service/Network.dart';
import 'package:crusher/Widget/CustomCircular.dart';
import 'package:crusher/Widget/powered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class SignInUserAgent extends StatefulWidget {
  String? status;

  SignInUserAgent({Key? key, this.status}) : super(key: key);

  @override
  _SignInUserAgentState createState() => _SignInUserAgentState();
}

class _SignInUserAgentState extends State<SignInUserAgent> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WebServices network = Provider.of<WebServices>(context, listen: false);
    DataProvider provide = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
            child: Container(
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/recycle.jpeg',
                  alignment: new Alignment(0.27, 0.0),
                  scale: 1.5,
                  fit: BoxFit.none,
                )),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0, 0.09),
                    colors: [Colors.transparent, Color(0xFFFCFFFD)]),
              ),
              child: Text('')),
          Container(
            alignment: Alignment.bottomLeft,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Sign In',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Please enter your details to sign in',
                          style:
                              TextStyle(color: Color(0xC2141414), fontSize: 15),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, bottom: 10, top: 30),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFF141414).withOpacity(0.35),
                          ),
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color(0xC2141414),
                        onChanged: (value) {
                          provide.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email cannot be empty';
                          } else if (!value.contains('@') ||
                              !value.contains('.com')) {
                            return 'please enter a valid email';
                          }
                        },
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "example@gmail.com",
                          hintStyle: TextStyle(color: Color(0xC2141414)),
                          focusColor: Color(0xC2141414),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                        ),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, bottom: 10, top: 30),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: Color(0xFF141414).withOpacity(0.35),
                          ),
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          provide.password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password cannot be empty';
                          } else if (value.length <= 5) {
                            return 'password length must be greater than 5';
                          }
                        },
                        obscureText: true,
                        cursorColor: Color(0xC2141414),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "************",
                          hintStyle: TextStyle(color: Color(0xC2141414)),
                          focusColor: Color(0xC2141414),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 30),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF00A85A)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(54.0),
                          ))),
                      child: Container(
                        width: 250,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)),
                        child: Text('Sign In'),
                      ),
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (formKey.currentState!.validate()) {
                          circularCustom(context);

                          widget.status=='user'? network.LoginUser(
                            context: context,
                            password: provide.password,
                            email: provide.email,
                          ):network.LoginUser(
                            context: context,
                            password: provide.password,
                            email: provide.email,
                          );
                        }
                      },
                    ),
                  ),
                  poweredBy()
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
