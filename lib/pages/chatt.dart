part of 'index.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController msgEditingController = TextEditingController();
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              CircleAvatar(
                child: Text(
                  "US"
                ),
              )
            ],
          ),
          leadingWidth: 90.0,
          title: Text(
            "Undr Support",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17.0
            )),
          actions: [
            IconButton(
              splashRadius: 20.0,
              icon: Icon(Icons.more_vert),
              onPressed: (){},
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
            children: [
          Flexible(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 0.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
              ),
            ),
          ),
          buildInput()
        ]),
      ),
    );
  }





  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.image),
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.face),
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(msgEditingController.text, 0);
                },
                style: TextStyle(fontSize: 15.0),
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                controller: msgEditingController,
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.send),
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  void onSendMessage(String content, int type) {
    if(content.trim() != ''){
      msgEditingController.clear();
      var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc("sdeNisa")
        .collection("sdeNisa")
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
      Firestore.instance.runTransaction((transaction) async{
        await transaction.set(documentReference, {
          // 'idFrom': id,

        });
      });
    }
  }
}
