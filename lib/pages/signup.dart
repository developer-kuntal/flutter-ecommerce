import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/pages/home.dart';

import 'package:flutter_shopping/pages/login.dart';
import 'package:flutter_shopping/db/users.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

 final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 final _formKey = GlobalKey<FormState>();
 UserServices _userServices = UserServices();

 TextEditingController _emailTextController = TextEditingController();
 TextEditingController _passwordTextController = TextEditingController();
 TextEditingController _nameTextController = TextEditingController();
 TextEditingController _confirmPasswordController = TextEditingController();
 String gender;
 String groupValue = "male";
 bool loading = false;
 bool hidePass = true;
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
                                  controller: _nameTextController,
                                  decoration: InputDecoration(
                                    hintText: "Full name",
                                    icon: Icon(Icons.person_outline),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "The name field cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          
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
                            padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: new Container(
                              color: Colors.white.withOpacity(0.4),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      title: Text("male", textAlign: TextAlign.end, style: TextStyle(color: Colors.white),
                                    ),
                                    trailing:Radio(value: "male", groupValue: groupValue, onChanged: (e) => valueChanged(e)),
                                  )),
                                  Expanded(
                                    child: ListTile(
                                      title: Text("female", textAlign: TextAlign.end, style: TextStyle(color: Colors.white),
                                    ),
                                    trailing:Radio(value: "female", groupValue: groupValue, onChanged: (e) => valueChanged(e)),
                                  )),
                                  // Expanded(child: Radio(value: "female", groupValue: groupValue, onChanged: (e) => valueChanged(e),)),
                                ],
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
                                child: ListTile(
                                    title: TextFormField(
                                    controller: _passwordTextController,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value){
                                      if(value.isEmpty){
                                        return "The password field cannot be empty";
                                      } else if(value.length < 6){
                                        return "the password has to be at least 6 characters long";
                                      } else if(_passwordTextController.text != value){
                                        return "the password do not match";
                                      }
                                      return null;
                                    },
                                    obscureText: hidePass,
                                  ),
                                  trailing: IconButton(icon: Icon(Icons.remove_red_eye,), onPressed: (){
                                    setState(() {
                                      hidePass = false; 
                                    });
                                  },),
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
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                      hintText: "Confirm password",
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
                                    obscureText: hidePass,
                                  ),
                                  trailing: IconButton(icon: Icon(Icons.remove_red_eye,), onPressed: (){
                                    setState(() {
                                      hidePass = false; 
                                    });
                                  },),
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
                              child: MaterialButton(
                                onPressed: (){
                                  validateForm();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text("Sign up", textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                              )
                            ),
                          ),
                          //  Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                            },
                            child: Text("Login!",textAlign: TextAlign.center, 
                            style: TextStyle(color: Colors.amber,  fontWeight: FontWeight.w400, fontSize: 16.0),),),
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

  valueChanged(e) {
    setState(() {
     if(e == "male") {
       groupValue = "male";
       gender = e;
     } else if(e == "female") {
       groupValue = "female";
       gender = e;
     }
    });
  }

  Future<void> validateForm() async{
    FormState formState = _formKey.currentState;
    // Map value;
    if(formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if(user == null) {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: _emailTextController.text, 
          password: _passwordTextController.text).then((user) => {
            _userServices.createUser({
              "username": _nameTextController.text,
              "email": _emailTextController.text,
              "userId": user.uid,
              "gender": gender,
            })
          }).catchError((e) => {
            print(e.toString())
          });

          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    }
  }
}