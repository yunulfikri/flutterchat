part of 'index.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  String networkImage = "";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("")),
                    borderRadius: BorderRadius.circular(double.infinity)
                  ),
                ),
                IconButton(icon: Icon(Icons.image), onPressed: (){}),
                IconButton(icon: Icon(Icons.camera), onPressed: (){}),
                TextField(
                  controller: _fullname,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}