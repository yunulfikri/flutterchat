part of 'index.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String phoneNumber= "00";
  @override
  void initState() {
    super.initState();
    calldata();
  }
  calldata(){
    setState(() {
      phoneNumber = FirebaseAuth.instance.currentUser.phoneNumber;
    });
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.white70,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: "CHAT",),
                Tab(text: "TIMELINE",),
                Tab(text: "PROFILE",),
              ],
            ),
            title: Text('Undr'),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              )
            ],
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Kupi App"),
    //   ),
    //
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 10.0),
    //         child: Column(
    //           children: [
    //             Text(
    //               phoneNumber
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}