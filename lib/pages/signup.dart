part of 'index.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Full Name"),
                  controller: _fullname,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Nickname"),
                  controller: _nickname,
                ),
                FlatButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var firebaseUser = FirebaseAuth.instance.currentUser;
                      String tokenMsg = await FirebaseMessaging().getToken();
                      prefs.setString("tokenMsg", tokenMsg);
                      await usersCollection.doc(firebaseUser.uid).set({
                        'uid': firebaseUser.uid.toString(),
                        'fullname': _fullname.text,
                        'nickname': _nickname.text,
                        'tokenMsg': tokenMsg
                      }).then((result) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                      }).catchError((onError) {
                        print("something error");
                        print(onError.toString());
                      });
                    },
                    child: Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
