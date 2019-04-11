import 'package:flutter/material.dart';
import 'package:flutter_shopping/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// my own import
// import 'package:flutter_shopping/pages/home.dart';
import 'package:flutter_shopping/pages/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true; 
    });

    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    FirebaseUser user = await firebaseAuth.currentUser().then((user){
      if(user != null) {
        setState(() => isLogedin = true );
      }
    });

    if(isLogedin) {
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => MyHomePage()));
    }

    setState(() {
     loading = false; 
    });

  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
     loading = true; 
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    FirebaseUser firebaseUser = await firebaseAuth.signInWithCredential(credential);
    if(firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance.collection("users")
                .where("id", isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0) {
        // insert the user to our collection
        Firestore.instance.collection("users").document(firebaseUser.uid).setData({
          "id" : firebaseUser.uid,
          "username" : firebaseUser.displayName,
          "profilePicture" : firebaseUser.photoUrl,
          "email" : firebaseUser.email,
        });

        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("profilePicture", firebaseUser.photoUrl);
        await preferences.setString("email", firebaseUser.email);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("profilePicture", documents[0]['photoUrl']);
        await preferences.setString("email", documents[0]['email']);
      }

      Fluttertoast.showToast(msg: "Login successful");
      setState(() {
       loading = false; 
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {  
      Fluttertoast.showToast(msg: "Login failed :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset("images/bg.jpg", fit: BoxFit.fill, 
            width: double.infinity,height: double.infinity,),
          
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),
          
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset("images/lg.png"),
            width: 280.0,
            height: 240.0,
          ),

          Center(
            child: Padding(
               padding: const EdgeInsets.only(top: 200.0),
               child: Center(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.4),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left:12.0),
                                child: TextFormField(
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    icon: Icon(Icons.alternate_email),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Please make sure your email address is valid';
                                      else
                                        return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.4),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left:12.0),
                                child: TextFormField(
                                  controller: _passwordTextController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "The password field cannot be empty";
                                    }else if(value.length < 6){
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.blue.shade700,
                              elevation: 0.0,
                              child: MaterialButton(onPressed: (){},
                              minWidth: MediaQuery.of(context).size.width,
                                child: Text("Login", textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                              )
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Forgot password", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w400,),),
                          ),
                          // Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            },
                            child: Text("Sign up!",textAlign: TextAlign.center, 
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 16.0),),),
                          ),
                          Divider(color: Colors.white,),
                            Text("Other login in opntion",textAlign: TextAlign.center, 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.red,
                                  elevation: 0.0,
                                  child: MaterialButton(onPressed: (){
                                    handleSignIn();
                                  },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset('images/google.png', width: 30.0, height: 30.0,),
                                    ),
                                        Text(" google", textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 22.0),),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
             ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),)
        ],
      ),
    );
  }
}