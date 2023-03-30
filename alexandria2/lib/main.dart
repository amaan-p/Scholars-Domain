import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flip_card/flip_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Studyapp()
  ));
}


/////////////////////////////////splashscreen///////////////////////////////////////////

class Studyapp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    Timer(const Duration(seconds: 3),()=> Navigator.of(context).push(_createRoute()));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("assets/images/splashscreen.png"),
                fit:BoxFit.cover
            )
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration:Duration(seconds: 3) ,
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          child: child,
          opacity:animation,
        );
      },
    );
  }
}

///////////////////////////////////////////login page/////////////////////////////
class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("assets/images/splashscreen.png"),
                fit:BoxFit.cover
            )
        ),
        child: Column(
          children: [
            SizedBox(height: 560,width: 1000,child: Text(""),)
            , SizedBox(height: 50,width: 170,
                child:ElevatedButton(style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.black)
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                      255, 99, 99, 99)),
                ),onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>Loginscreen()
                      ));
                }, child: Text("Login",style: TextStyle(color: Colors.black, fontSize: 25),),)),
            SizedBox(height: 30,width: 1000,child: Text(""),),
            Text("Ready to Learn? Login",style: TextStyle(color: Color.fromARGB(255, 99, 99, 99), fontSize: 14),)
          ],
        ),
      ),
    );
  }


}

//////////////////////////////////////login screen////////////////////////////////////////
class my_controllers{
  static var phno_controller=TextEditingController();
  static var otp_controller=TextEditingController();
  @override
  void dispose(){
    phno_controller.dispose();
    otp_controller.dispose();
  }
}

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login.png"),
                  fit: BoxFit.cover),
            )
            ,child: Center(
            child: Column(
                children: <Widget>[
                  SizedBox(child: Text(""),height: 130,),
                  Text("Login",style: TextStyle(color: Color.fromARGB(255, 99, 99, 99),fontSize: 55,fontFamily: "DavidLibre"),),
                  SizedBox(child: Text(""),height: 70,),
                  SizedBox(
                      width: 270,
                      child:TextFormField(
                        controller: my_controllers.phno_controller,
                        style: TextStyle(color:Colors.grey ,fontSize: 20),
                        decoration: const InputDecoration(

                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:Colors.grey  ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:Colors.grey ),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Colors.grey ),
                            ),
                            label: Text("Enter Phone Number"),
                            labelStyle: TextStyle(
                                color:Colors.grey ,
                                fontSize: 18
                            )
                        ),

                      )), SizedBox(child: Text(""),height: 70,),

                  SizedBox(width:160,height:40,child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>Homescreen()
                          ));

                      /*FirebaseAuth auth = FirebaseAuth.instance;

                            await auth.verifyPhoneNumber(
                                phoneNumber:"+91${my_controllers.phno_controller.text}",
                                verificationCompleted: (PhoneAuthCredential credential) async {
                                  //await auth.signInWithCredential(credential);
                                      (AuthCredential authCredential){
                                    auth.signInWithCredential(credential).then((UserCredential result){
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) => Homescreen()
                                      ));
                                    }).catchError((e){
                                      print(e);
                                    });
                                  };
                                },
                                verificationFailed: (FirebaseAuthException e) {
                                  if (e.code == 'invalid-phone-number') {
                                    print('The provided phone number is not valid.');
                                  }},
                                codeSent: (String verificationId, int? resendToken) async {
                                  // Update the UI - wait for the user to enter the SMS code
                                  showDialog(context: context, builder: (BuildContext context) {

                                    return Container(
                                        alignment: Alignment.center,
                                        child:AlertDialog(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(new Radius.circular(50.0)),
                                          ),
                                          title:Center(
                                              child:Text('Verify OTP',style:TextStyle(color:Colors.grey.shade800,fontSize: 25,fontFamily:'DavidLibre'))
                                          ),
                                          actions: <Widget>[

                                            PinCodeTextField(
                                              length: 6,
                                               controller: my_controllers.otp_controller,
                                              obscureText: false,
                                              textStyle: TextStyle(color:Colors.grey.shade500),
                                              animationType: AnimationType.fade,
                                              pinTheme: PinTheme(
                                                shape: PinCodeFieldShape.box,
                                                borderRadius: BorderRadius.circular(5),
                                                fieldHeight: 50,
                                                fieldWidth: 40,

                                                activeFillColor: Colors.grey.shade800,
                                                inactiveFillColor: Colors.transparent,
                                                inactiveColor: Colors.grey.shade800,
                                                activeColor: Colors.transparent,
                                                selectedColor: Colors.transparent,

                                              ),
                                              animationDuration: const Duration(milliseconds: 300),
                                              backgroundColor: Colors.transparent,

                                              onCompleted: (v) {
                                                debugPrint("Completed");
                                              },
                                              onChanged: (value) {
                                              },
                                              beforeTextPaste: (text) {
                                                return true;
                                              },
                                              appContext: context,
                                            ),
                                            SizedBox(
                                                height: 70,
                                                child:Text("")
                                            ),Center(child:SizedBox(
                                                height: 50,width: 170,
                                                child:ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(50.0),
                                                          side: BorderSide(color:Colors.grey.shade800)
                                                      ),
                                                    ),
                                                    backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
                                                  ),

                                                  onPressed: () {  },
                                                  child:Text("Submit",style: TextStyle(color: Colors.black, fontSize: 26,fontFamily: "DavidLibre")),
                                                ))),
                                          ],
                                        )
                                    );
                                  }
                                  );

                                  String smsCode=my_controllers.otp_controller.text;
                                  // Create a PhoneAuthCredential with the code
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

                                  // Sign the user in (or link) with the credential
                                  await auth.signInWithCredential(credential);
                                }, codeAutoRetrievalTimeout: (String verificationId) {
                              // Auto-resolution timed out...
                            }
                            );

                          */}, child:Text("Submit",style: TextStyle(color: Colors.black, fontSize: 26)),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Color.fromARGB(255, 99, 99, 99))
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 99, 99, 99)),
                    ),

                  )

                  )

                ]
            )
        )
        )
    );
  }
}

/////////////////////////////////////////////Youtube screen//////////////
String ytid(String name){
  if(name=="java"){
    return "eIrMbAQSU34";
  }else if(name=="c"){
    return "CPjZKsUYSXg";
  }else if(name=="python"){
    return "kqtD5dpn9C8";
  }else if(name=="nodejs"){
    return "TlB_eWDSMt4";
  }else if(name=="dsa"){
    return "BBpAmxU_NQo";
  }else if(name=="mysql"){
    return "7S_tz1z_5bA";
  }else{
    return "Xe16AYWGmbY";
  }
}

String desc(String name){
  if(name=="java"){
    return "Java is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible. It is a general-purpose programming language intended to let programmers write once, run anywhere (WORA),[17] meaning that compiled Java code can run on all platforms that support Java without the need to recompile";
  }else if(name=="c"){
    return "A successor to the programming language B, C was originally developed at Bell Labs by Ritchie between 1972 and 1973 to construct utilities running on Unix. It was applied to re-implementing the kernel of the Unix operating system.[8] During the 1980s, C gradually gained popularity. It has become one of the most widely used programming languages,[9][10] with C compilers available for practically all modern computer architectures and operating systems";
  }else if(name=="python"){
    return "Python is a high-level, general-purpose programming language. Its design philosophy emphasizes code readability with the use of significant indentation. Python is dynamically-typed and garbage-collected. It supports multiple programming paradigms, including structured, object-oriented and functional programming";
  }else if(name=="nodejs"){
    return "Node.js is a cross-platform, open-source server environment that can run on Windows, Linux, Unix, macOS, and more. Node.js is a back-end JavaScript runtime environment, runs on the V8 JavaScript Engine, and executes JavaScript code outside a web browser";
  }else if(name=="dsa"){
    return "A data structure is a method of organizing data in a virtual system. Think of sequences of numbers, or tables of data: these are both well-defined data structures. An algorithm is a sequence of steps executed by a computer that takes an input and transforms it into a target output.";
  }else if(name=="mysql"){
    return "MySQL is an open-source relational database management system. Its name is a combination of 'My', the name of co-founder Michael Widenius's daughter My, and 'SQL', the acronym for Structured Query Language.";
  }else{
    return "Web development is the work involved in developing a website for the Internet or an intranet. Web development can range from developing a simple single static page of plain text to complex web applications, electronic businesses, and social network services";
  }
}

class course extends StatelessWidget{



  String sub;String topic;String notes;
  course(this.sub,this.topic,this.notes);


  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: ytid(sub),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 80,titleSpacing: 25,
          backgroundColor: Colors.transparent,
          title: Text("Course",style: TextStyle(color: Colors.white,fontSize:35)),
        ),
        body:Stack(
            children:[ Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/home.png"),
                    fit: BoxFit.cover),
              ),

            ),
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 120),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      alignment:Alignment.centerLeft,
                      child: Text(sub[0].toUpperCase() + sub.substring(1).toLowerCase(),
                        style: TextStyle(

                            fontSize: 40,
                            color: Colors.white,
                            fontFamily:"DavidLibre"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressColors: ProgressBarColors(
                        playedColor: Colors.grey,
                        handleColor: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 35,),
                    Container(
                      width: 360,
                      height: 425,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:[
                              Colors.grey.shade700,
                              Colors.grey.shade800,
                              Colors.transparent
                            ]
                        ),
                        borderRadius: BorderRadius.only(topRight:Radius.circular(35),topLeft: Radius.circular(35)),
                      ),
                      child: ListView(
                        padding: EdgeInsets.only(bottom: 20,top: 30,left: 20),
                        scrollDirection: Axis.vertical,

                        children: [
                          Text("Additional Resources",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white
                          ),),
                          Divider(height:10,thickness: 2,indent: 1,endIndent: 120,color: Colors.white,),
                          SizedBox(height: 8,),
                          Text("Part 1: Introduction",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          ),),
                          SizedBox(height: 10,),
                          Text(desc(sub),style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),),

                        ],

                      ),
                    ),


                  ],
                ),
              )
            ]
        )
    );
  }

}
///////////////////////////Home Screen///////////////////////////////////////////////

class Homescreen extends StatefulWidget{
  @override
  State<Homescreen> createState()=>_Homescreen();

}
class _Homescreen extends State<Homescreen>{
  @override
  void initState() {
    super.initState();
  }

  int selectedindex=0;

  List<Widget> _pages=[
    Home(),
    All_courses(),
    Favorites(),
    Profile()
  ];


  void navigation(int index){
    setState(() {
      selectedindex=index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

        resizeToAvoidBottomInset : false,
        extendBody: true,
        /////////////////navbar/////////////////////
        bottomNavigationBar:
        Container(
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: GNav(
              color: Colors.white,
              activeColor: Colors.white,
              padding: EdgeInsets.all(13),
              gap: 8,
              onTabChange:(index){
                navigation(index);
              },
              tabs: const[
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.apps,
                  text: "All Courses",
                ),
                GButton(
                  icon: Icons.book_outlined,
                  text: "My Courses",
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: "Profile",
                ),
              ],
            ),
          ),

        ),
        //////////////////////////////////////////////////////////////////////
        body:_pages[selectedindex]
    );
  }
}
////////////////////////////////////////Home/////////////////////////////
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,titleSpacing: 25,
          backgroundColor: Colors.transparent,
          title: Text("Explore",style: TextStyle(color: Colors.white,fontSize:35)),
        ),
        body:Stack(
            children:[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/home.png"),
                      fit: BoxFit.cover),
                ),

              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 130,),
                    Text("Popular Courses",style: TextStyle(color: Colors.grey.shade500,fontSize:30)),
                    SizedBox(height: 15,),
                    SizedBox(
                        height: 330,
                        width: 500,
                        child:CarouselSlider(
                          items: [
                            Mostpopular("java", "topic", "notes"),
                            Mostpopular("python", "topic", "notes"),
                            Mostpopular("c", "topic", "notes"),
                          ], options: CarouselOptions(
                          autoPlay:true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.68,
                          aspectRatio: 1,
                          initialPage: 1,
                        ),)
                    ),
                    SizedBox(height:20),
                    Text("Catagories",style: TextStyle(color: Colors.grey.shade500,fontSize:30)),
                    SizedBox(height:20),
                    Container(
                      height: 200,
                      child:ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              //set border radius more than 50% of height and width to make circle
                            ),
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: Colors.grey.shade800,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      'Programming',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    const Text(
                                      'Boost Your Programming Knowledge with these Courses ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    SizedBox(
                                      width: 140,

                                      child: ElevatedButton(
                                        onPressed: () =>
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>All_courses()
                                                )),
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(Colors.black)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.add_outlined),
                                              Text('View More')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ) //SizedBox
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              //set border radius more than 50% of height and width to make circle
                            ),
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: Colors.grey.shade800,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      'Algorithms',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    const Text(
                                      'Boost Your Data Structure Knowledge with these Courses ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    SizedBox(
                                      width: 140,

                                      child: ElevatedButton(
                                        onPressed: () =>   Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>All_courses()
                                            )),
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(Colors.black)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.add_outlined),
                                              Text('View More')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ) //SizedBox
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              //set border radius more than 50% of height and width to make circle
                            ),
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: Colors.grey.shade800,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      'Mathematics',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    const Text(
                                      'Boost Your Maths Knowledge with these Courses ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    SizedBox(
                                      width: 140,

                                      child: ElevatedButton(
                                        onPressed: () =>   Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>All_courses()
                                            )),
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(Colors.black)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.add_outlined),
                                              Text('View More')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ) //SizedBox
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )

            ]
        )

    );
  }
}


class Mostpopular extends StatelessWidget{
  Mostpopular(this.name,this.topic,this.notes);
  String name;
  String topic;
  String notes;

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        style:ButtonStyle(
          backgroundColor:  MaterialStatePropertyAll<Color>(Colors.transparent),
        ),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>course( name,topic,notes)
              ));
        },
        child:Container(
            height: 320,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    blurRadius: 15.0,
                  ),
                ],
c                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/sub/$name.png'),
                  fit: BoxFit.fill,
                )
            )));
  }
}

////////////////////////////////////////All Courses////////////////////////////////
List<String> searchTerms = [
  "Nodejs",
  "Python",
  "C",
  "Java",
  "DSA",
  "WebTech",
  "MySQL"
];
class CustomSearchDelegate extends SearchDelegate {


// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: (){
            query=result;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>course( query.toLowerCase(),"Part 1: Introduction","notes")
                ));
          },
        );
      },
    );
  }
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(
          headline6: TextStyle( // headline 6 affects the query text
            color: Colors.grey.shade800,
            fontSize: 20.0,
          )
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      ),
      inputDecorationTheme:
      InputDecorationTheme(
        hintStyle: TextStyle(color:Colors.grey.shade800),
        border: InputBorder.none,
      ),
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return Container(
        color:  Colors.grey.shade800,
        child:ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            var result = matchQuery[index];
            return ListTile(
              title: Text(result,style: TextStyle(color: Colors.black,fontSize:25,)),
              onTap: (){
                query=result;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>course( query.toLowerCase(),"Part 1: Introduction","notes")
                    ));
              },
            );
          },
        )
    );
  }
}


class All_courses extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,titleSpacing: 25,
          backgroundColor: Colors.transparent,
          title: Text("Discover",style: TextStyle(color: Colors.white,fontSize:35)),
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate()
                );
              },
              icon: const Icon(Icons.search),
            )
          ],

        ),
        body:Stack(

            children:[
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/home.png"),
                        fit: BoxFit.cover),
                  )
              ),

              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,

                  child:Column(
                    children: [
                      SizedBox(height:1),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 1300,
                        child:ListView(
                          // This next line does the trick.
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade800 //<-- SEE HERE
                                ),
                                borderRadius: BorderRadius.circular(20),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              elevation: 50,
                              shadowColor: Colors.grey.shade800,
                              color: Colors.black,
                              child: SizedBox(
                                width: 300,
                                height: 350,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          width:380,
                                          height: 240,
                                          child:IconButton(
                                            icon: Image.asset('assets/images/sub/mysql.png'),
                                            iconSize: 50,
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) =>course( "mysql","Part 1: Introduction","notes")
                                                  ));
                                            },
                                          )
                                      ) ,
                                      SizedBox(
                                        height: 1,
                                      ), //SizedBox
                                      Text(
                                        'Introduction to MySQL',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w500,
                                        ), //Textstyle
                                      ), //Text
                                      SizedBox(
                                        height: 18,
                                      ), //SizedBox
                                      Text(
                                        'A Hands on Course for MySQL Databases',
                                        style: TextStyle(
                                          fontSize:16,
                                          color: Colors.grey,
                                        ), //Textstyle
                                      ),//Text
                                      //SizedBox
                                    ],
                                  ), //Column
                                ), //Padding
                              ), //SizedBox
                            ),
                            SizedBox(height:5),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade800 //<-- SEE HERE
                                ),
                                borderRadius: BorderRadius.circular(20),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              elevation: 50,
                              shadowColor: Colors.grey.shade800,
                              color: Colors.black,
                              child: SizedBox(
                                width: 300,
                                height: 350,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          width:380,
                                          height: 240,
                                          child:IconButton(
                                            icon: Image.asset('assets/images/sub/nodejs.png'),
                                            iconSize: 50,
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) =>course( "nodejs","Part 1: Introduction","notes")
                                                  ));
                                            },
                                          )
                                      ) ,
                                      SizedBox(
                                        height: 1,
                                      ), //SizedBox
                                      Text(
                                        'Introduction to NodeJs',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w500,
                                        ), //Textstyle
                                      ), //Text
                                      SizedBox(
                                        height: 18,
                                      ), //SizedBox
                                      Text(
                                        'A Hands on Course for NodeJs Language',
                                        style: TextStyle(
                                          fontSize:16,
                                          color: Colors.grey,
                                        ), //Textstyle
                                      ),//Text
                                      //SizedBox
                                    ],
                                  ), //Column
                                ), //Padding
                              ), //SizedBox
                            ),
                            SizedBox(height:5),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade800 //<-- SEE HERE
                                ),
                                borderRadius: BorderRadius.circular(20),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              elevation: 50,
                              shadowColor: Colors.grey.shade800,
                              color: Colors.black,
                              child: SizedBox(
                                width: 300,
                                height: 350,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          width:380,
                                          height: 240,
                                          child:IconButton(
                                            icon: Image.asset('assets/images/sub/dsa.png'),
                                            iconSize: 50,
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) =>course( "dsa","Part 1: Introduction","notes")
                                                  ));
                                            },
                                          )
                                      ) ,
                                      SizedBox(
                                        height: 1,
                                      ), //SizedBox
                                      Text(
                                        'Introduction to Algorithms',
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w500,
                                        ), //Textstyle
                                      ), //Text
                                      SizedBox(
                                        height: 18,
                                      ), //SizedBox
                                      Text(
                                        'A Hands on Course for Algorithms',
                                        style: TextStyle(
                                          fontSize:16,
                                          color: Colors.grey,
                                        ), //Textstyle
                                      ),//Text
                                      //SizedBox
                                    ],
                                  ), //Column
                                ), //Padding
                              ), //SizedBox
                            ),
                          ],
                        ),
                      ),

                    ],
                  )
              )

            ]
        ));
  }
}

String prop_course(String name){
  List<String> fname=name.split(".");
  return fname[0];
}
class All_cour extends StatelessWidget{
  All_cour(this.name);
  String name;
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        style:ButtonStyle(
          backgroundColor:  MaterialStatePropertyAll<Color>(Colors.transparent),
        ),
        onPressed: (){

          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>course( prop_course(name.toLowerCase()),"Part 1: Introduction","notes")
              ));
        },
        child:Container(
          padding: EdgeInsets.all(7),
          height: 110,
          width: 151,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              image:DecorationImage(image: AssetImage( 'assets/images/sub/$name'),
                  fit:BoxFit.fill
              )
          ),
        ));
  }
}
////////////////////////////////////////Favs/////////////////////
class Favorites extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,titleSpacing: 25,
        backgroundColor: Colors.transparent,
        title: Text("Courses",style: TextStyle(color: Colors.white,fontSize:35)),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/home.png"),
              fit: BoxFit.cover),
        ),
        child:Container(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.grey.shade500,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.only(top: 100),
                  tabs: <Widget>[
                    Tab(text:"Ongoing"),
                    Tab(text: "Completed"),
                  ],
                ),
                Container(
                  alignment:Alignment.topCenter,
                  height: 700,
                  child: TabBarView(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            height: 550,
                            child: ListView(
                              padding: EdgeInsets.only(bottom: 20,top: 10),
                              scrollDirection: Axis.vertical,
                              children: [
                                InkWell(
                                  child: assignment(title: "MySQL", name: 'Introduction 1: MySQL', date: '23 Minutes Remaining',),
                                  onTap: (){},
                                ),


                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 550,
                            child: ListView(
                              padding: EdgeInsets.only(bottom: 20,top: 10),
                              scrollDirection: Axis.vertical,
                              children: [
                                InkWell(
                                  child: assignment_c(title: 'Java', name: 'Introduction 1: Java',),
                                  onTap: (){},
                                ),
                                InkWell(
                                  child: assignment_c(title: 'Python', name: 'Introduction 1: Python',),
                                  onTap: (){},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class assignment extends StatelessWidget {
  final String title;

  final String name;
  final String date;
  const assignment({Key? key, required this.title, required this.name, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only( top: 5),
                  height: 25, width: 25,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text(title.substring(0, 1)),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  margin: EdgeInsets.only(top: 03),
                  child: Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white70 ),),
                ),
                SizedBox(width: 180,),

              ],
            ),
            SizedBox(height: 15,),
            Align(
                alignment: Alignment.topLeft,
                child: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
            SizedBox(height: 10,),
            Align(
                alignment: Alignment.topLeft,
                child: Text(date, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey.shade500)))
          ],
        ),
      ),
    );
  }
}

class assignment_c extends StatelessWidget {
  final String title;
  final String name;
  const assignment_c({Key? key, required this.title, required this.name,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10,top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only( top: 5),
                  height: 25, width: 25,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text(title.substring(0, 1)),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  margin: EdgeInsets.only(top: 03),
                  child: Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white70 ),),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Align(
                alignment: Alignment.topLeft,
                child: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
////////////////////////////////////////Profile/////////////////
class Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,titleSpacing: 25,
          backgroundColor: Colors.transparent,
          title: Text("Dashboard",style: TextStyle(color: Colors.white,fontSize:35)),
        ),
        body:
        Stack(
            children:[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/home.png"),
                      fit: BoxFit.cover),
                ),),
              Column(
                children: [
                  SizedBox(width:80,height: 100,),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          width: 200,
                          height: 200,
                          decoration:BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/av.jpg"),
                                  fit: BoxFit.cover
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white30
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Amaan Patel",
                          style: TextStyle(fontSize: 35,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Text('Courses Completed',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 15,),
                            SizedBox(
                              height: 135,
                              width: 340,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Coursetab("#1 Java"),
                                      SizedBox(height: 15,),
                                      Coursetab("#2 Python")
                                    ],
                                  ) ),
                            ),
                            SizedBox(height: 20,),
                            Text('Courses Enrolled',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 15,),
                            SizedBox(
                              height: 135,
                              width: 340,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Coursetab("#1 MySQL"),
                                      SizedBox(height: 15,),
                                    ],
                                  ) ),
                            )

                          ],
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ])
    );
  }
}

class Coursetab extends StatelessWidget{
  Coursetab(this.name);
  String name;
  @override
  Widget build(BuildContext context){
    return InkWell(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade800,
        ),
        child: Text(name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black
          ),
        ),
        alignment: Alignment.center,
      ),
      onTap: (){},
    );
  }
}