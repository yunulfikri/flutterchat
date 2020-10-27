part of 'index.dart';

class MyProfileScreen extends StatefulWidget {
  final String fullname, profileImage, location, bio;
  final bool verified;
  MyProfileScreen(
      this.fullname, this.profileImage, this.location, this.verified, this.bio);
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  double lat, long;
  File _image;
  final picker = ImagePicker();
  // List<Featured> imageList = [];

  double luas;
  SharedPreferences prefs;
  String currentUserid;
  String fullname, profileImage, location, bio;
  bool verified;

  // getPostData() {
  //   DatabaseService()
  //       .getMyProfilePost()
  //       .then((value) => {value.documents.forEach((res) {})});
  // }

  //for my_profile
  // getDataUser() {
  //   DatabaseService().getUserData().then((value) async {
  //     print(value);
  //     setState(() {
  //       fullname = value['fullname'];
  //       profileImage = value['profilePhoto'];
  //       verified = value['verified'];
  //       bio = value['bio'];
  //       lat = value['position']['lat'];
  //       long = value['position']['long'];
  //     });
  //     String loc = await GeoService().getAddress(lat, long);
  //     setState(() {
  //       location = loc;
  //     });
  //   });
  // }

  Future getImageGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
    _cropImage(_image);
    updateProfileImage();
  }

  Future<Null> _cropImage(imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.pinkAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        _image = File(imageFile.path);
      });
    } else {
      setState(() {
        _image = null;
      });
    }
  }

  updateProfileImage() async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    List<String> splitPath = _image.path.split('/');
    String filename = splitPath[splitPath.length - 1];
    StorageReference ref =
        firebaseStorage.ref().child('images').child(filename);
    StorageUploadTask uploadTask = ref.putFile(_image);
    StreamSubscription streamSubscription =
        uploadTask.events.listen((event) async {
      var eventType = event.type;
      if (eventType == StorageTaskEventType.progress) {
        setState(() {
          isLoading = true;
        });
      } else if (eventType == StorageTaskEventType.failure) {
        scaffoldState.currentState
            .showSnackBar(SnackBar(content: Text("Photo failed to upload")));
        setState(() {
          isLoading = false;
        });
      } else if (eventType == StorageTaskEventType.success) {
        var downloadUrl = await event.snapshot.ref.getDownloadURL();
        // call database service
        // DatabaseService().updateProfileImage(downloadUrl);
        // getDataUser();
      }
    });
    // await uploadTask.onComplete.then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   streamSubscription.cancel();
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Menu(
    //         indexTo: 2,
    //       ),
    //     ),
    //   );
    // });
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Menu(
    //       indexTo: 2,
    //     ),
    //   ),
    // );
  }

  setInitData() async {
    prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('currentUserUid');
    setState(() {
      currentUserid = uid;
    });
  }

  @override
  void initState() {
    super.initState();
    fullname = widget.fullname;
    profileImage = widget.profileImage;
    bio = widget.bio;
    verified = widget.verified;
    setInitData();
    // getDataUser();
    // getPostData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 12.0,
        backgroundColor: Color(0xFFfa5a19),
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/post');
        },
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.settings,
                            size: 22.0,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            // AuthService().signOut();
                            Navigator.pushReplacementNamed(context, '/');
                          }),
                      IconButton(
                        icon: Icon(
                          Icons.mode_edit,
                          size: 22.0,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/changeprofile');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150.0),
                    border: Border.all(color: Color(0xFFfa5a19), width: 0.5),
                    image: DecorationImage(
                      image: profileImage == null
                          ? AssetImage('assets/images/loading.gif')
                          : CachedNetworkImageProvider(profileImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xFFfa5a19),
                      ),
                      child: IconButton(
                        onPressed: () {
                          getImageGallery();
                        },
                        icon: Icon(Icons.add_a_photo,
                            size: 14.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Column(
                    children: <Widget>[
                      Text(
                        fullname == null ? "" : fullname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      bio == null
                          ? Column()
                          : Text(
                              bio,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black45),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          splashColor: Colors.transparent,
                          child: Icon(
                            Icons.verified_user,
                            color: verified == true
                                ? Color(0xFFfa5a19)
                                : Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                            verified == true
                                ? "Verified Accounts"
                                : "Unverified Account",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black))
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Color(0xFFfa5a19)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.location == null
                              ? "Please wait"
                              : widget.location,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: luas == null
                  ? 10
                  : luas * MediaQuery.of(context).size.width * 1.3,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Posts')
                    .where("useruid", isEqualTo: currentUserid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFfa5a19)),
                    );
                  } else {
                    var jumlahData = snapshot.data.documents.length.toString();
                    luas = double.parse(jumlahData);
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) =>
                          buildItem(context, snapshot.data.documents[index]),
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                fullname,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Color(0xFFfa5a19)),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                  size: 18.0,
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Column(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(document['image']),
              ),
            ),
          ),
          Text(document['caption'])
        ],
      ),
    );
  }
}
