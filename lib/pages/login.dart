import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _phonecontroller = TextEditingController();
  String initialCountry = 'ID';
  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  String phonenumber = "";


  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/img/beans.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal:120.0),
            margin: EdgeInsets.only(top: 50.0),
            child: Center(
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal:120.0, vertical: 10.0),
            margin: EdgeInsets.only(bottom: 30.0),
            child: Center(
                child: Text(
                  "Kupi Chatt",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.white
                  ),
                )
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget LoginPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/img/beans.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal:120.0),
            margin: EdgeInsets.only(top: 50.0),
            child: Center(
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.redAccent,
                size: 50.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal:120.0, vertical: 10.0),
            margin: EdgeInsets.only(bottom: 30.0),
            child: Center(
              child: Text(
                  "Kupi Chatt",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.redAccent
                ),
              )
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "Phone number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number){
                      setState(() {
                        phonenumber = number.phoneNumber;
                      });
                    },
                    initialValue: number,
                    textFieldController: _phonecontroller,
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.redAccent,
                    onPressed: verifyPhone,
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String status = "---";
  Future authLogin()async{
    print(phonenumber);
  }

  String phoneNo;
  String smsCode;
  String verificationId;
  final _codeController = TextEditingController();
  Future<void> verifyPhone() async {

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("Enter SMS Code"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _codeController,
              )
            ],
          ),
          actions: [
            FlatButton(
              child: Text("Confirm"),
              textColor: Colors.white,
              color: Colors.redAccent,
              onPressed: ()async{
                smsCode = _codeController.text.trim();
                AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
                await _auth.signInWithCredential(credential).then((result) {
                  if(result.user != null){
                    print("sukses login");
                    print(result.user.phoneNumber);
                  }else{
                    print("Error verified");
                  }
                });
                
              },
            )
          ],
        )
      );
    };

    final PhoneVerificationCompleted verifiedSuccess = (PhoneAuthCredential user) {

      Navigator.of(context).pop();
    };

    final PhoneVerificationFailed veriFailed = (FirebaseAuthException exception) {
      setState(() {
        status = "Kode Verifikasi Salah";
      });
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phonenumber,
        codeAutoRetrievalTimeout: null,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }


  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _controller,
              physics: new AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                HomePage(),
                LoginPage()
              ],
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }
}
