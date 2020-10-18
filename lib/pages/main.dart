part of 'index.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final firebaseMessaging = FirebaseMessaging();
  String phoneNumber = "00";
  final controllerTopic = TextEditingController();
  bool isSubscribed = false;
  String token = '';
  static String dataName = '';
  static String dataAge = '';

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) {
    debugPrint('onBackgroundMessage: $message');
    if (message.containsKey('data')) {
      String name = '';
      String age = '';
      if (Platform.isIOS) {
        name = message['name'];
        age = message['age'];
      } else if (Platform.isAndroid) {
        var data = message['data'];
        name = data['name'];
        age = data['age'];
      }
      dataName = name;
      dataAge = age;
      debugPrint('onBackgroundMessage: name: $name & age: $age');
    }
    return null;
  }

  void getDataFcm(Map<String, dynamic> message) {
    String name = '';
    String age = '';
    if (Platform.isIOS) {
      name = message['name'];
      age = message['age'];
    } else if (Platform.isAndroid) {
      var data = message['data'];
      name = data['name'];
      age = data['age'];
    }
    if (name.isNotEmpty && age.isNotEmpty) {
      setState(() {
        dataName = name;
        dataAge = age;
      });
    }
    debugPrint('getDataFcm: name: $name & age: $age');
  }
  @override
  void initState() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        debugPrint('onMessage: $message');
        getDataFcm(message);
      },
      onBackgroundMessage: onBackgroundMessage,
      onResume: (Map<String, dynamic> message) async {
        debugPrint('onResume: $message');
        getDataFcm(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        debugPrint('onLaunch: $message');
        getDataFcm(message);
      },
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true),
    );
    firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      debugPrint('Settings registered: $settings');
    });
    firebaseMessaging.getToken().then((token) => setState(() {
      this.token = token;
    }));
    tokenprint();
    super.initState();
    calldata();

  }
  tokenprint() async{
    String y = await firebaseMessaging.getToken();
    print("token = " + y);
  }
  calldata() {
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
                Tab(
                  text: "CHAT",
                ),
                Tab(
                  text: "TIMELINE",
                ),
                Tab(
                  text: "PROFILE",
                ),
              ],
            ),
            title: Text('Undr'),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
          ),
          body: TabBarView(
            children: [
              ChatList(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatData {
  final String uid, name, content, picture, type, time;

  ChatData(
      {this.uid,
      this.name,
      this.content,
      this.picture,
      this.type,
      this.time});
}

class ChatList extends StatelessWidget {
  List<ChatData> chatDummy = [
    ChatData(
        uid: "sdnskdnawssd",
        name: "Bella Cantik",
        content: "Jadi kerumah engga? kosong nih",
        picture:
            "https://images.pexels.com/photos/2683896/pexels-photo-2683896.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "r",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawd",
        name: "Sinta",
        content: "Hai apa kabar",
        picture:
            "https://images.pexels.com/photos/4884147/pexels-photo-4884147.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "s",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Delia",
        content: "Hai apa kabar",
        picture:
            "https://images.pexels.com/photos/2683896/pexels-photo-2683896.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "r",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Yunul",
        content: "Bagaimana kabarmu?",
        picture: "",
        type: "s",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Bella Cantik",
        content: "Jadi kerumah engga? kosong nih",
        picture:
        "https://images.pexels.com/photos/2683896/pexels-photo-2683896.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "r",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawd",
        name: "Sinta",
        content: "Hai apa kabar",
        picture:
        "https://images.pexels.com/photos/4884147/pexels-photo-4884147.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "s",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Delia",
        content: "Hai apa kabar",
        picture:
        "https://images.pexels.com/photos/2683896/pexels-photo-2683896.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "r",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Yunul",
        content: "Bagaimana kabarmu?",
        picture: "",
        type: "s",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Bella Cantik",
        content: "Jadi kerumah engga? kosong nih",
        picture:
        "https://images.pexels.com/photos/2683896/pexels-photo-2683896.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "r",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawd",
        name: "Sinta",
        content: "Hai apa kabar",
        picture:
        "https://images.pexels.com/photos/4884147/pexels-photo-4884147.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "s",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Delia",
        content: "Hai apa kabar",
        picture:
        "https://images.pexels.com/photos/2683896/pexels-photo-2683896.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        type: "r",
        time: "13:35"),
    ChatData(
        uid: "sdnskdnawssd",
        name: "Yunul",
        content: "Bagaimana kabarmu?",
        picture: "",
        type: "s",
        time: "13:35"),
  ];
  Widget _listSent(nama, content, pic, time,context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
        },
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        title: Text(nama, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Wrap(
          children: [
            Icon(
              Icons.check,
              size: 14.0,
            ),
            Text(
              content,
            )
          ],
        ),
        leading: CircleAvatar(
            child: pic == "" ? Text(nama[0]) : null,
            backgroundImage: pic == "" ? null : NetworkImage(pic)),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listRecv(nama, content, pic, time,context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          ),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        title: Text(nama, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Flex(
          direction: Axis.horizontal,
          children: [Text(content)],
        ),
        leading: CircleAvatar(
            child: pic == "" ? Text(nama[0]) : null,
            backgroundImage: pic == "" ? null : NetworkImage(pic)),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 3.0,
            ),
            Icon(
              Icons.brightness_1,
              size: 9.0,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatDummy.length,
      itemBuilder: (context, index) {
        if (chatDummy[index].type == "s") {
          return _listSent(chatDummy[index].name, chatDummy[index].content,
              chatDummy[index].picture, chatDummy[index].time, context);
        } else {
          return _listRecv(chatDummy[index].name, chatDummy[index].content,
              chatDummy[index].picture, chatDummy[index].time, context);
        }
      },
    );
  }
}
