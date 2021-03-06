import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

// my own imports
import 'package:flutter_shopping/components/horizental_listview.dart';
import 'package:flutter_shopping/components/products.dart';
import 'package:flutter_shopping/pages/cart.dart';
import 'package:flutter_shopping/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_shopping/functions/GlobalState.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalState _store = GlobalState.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _gSignIn = new GoogleSignIn( );
  bool isLoggedin = true;

  void _logOut() async {
    await _auth.signOut().then((response) {
      isLoggedin = false;
      setState(() { });
    });
    await _gSignIn.signOut();
    if(!isLoggedin) {
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/w3.jpeg'),
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/w1.jpeg'),
          AssetImage('images/w4.jpeg'),          
          // AssetImage('images/m2.jpg'),
        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        dotColor: Colors.amberAccent,
        indicatorBgPadding: 2.0,
      ),
    );  

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: new Text('Fashapp'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){},),
          new IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
          },),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            // header
            new UserAccountsDrawerHeader(
              accountName: Text("${_store.get('username')}"), // Kuntal Kanti Das
              accountEmail: Text("${_store.get('email')}"), // kuntalkantidas.besu@gmail.com
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage("${_store.get('profilePicture')}") ??
                        Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.red
              ),
            ),
            // body
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
              },
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(Icons.shopping_cart, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite, color: Colors.red,),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings,),
              ),
            ),
            InkWell(
              onTap: _logOut,
              child: ListTile(
                title: Text('Log out'),
                leading: Icon(Icons.exit_to_app, ),
              ),
            ),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          // image_carousel begins here

          image_carousel,

          // padding widget
          new Padding(padding: const EdgeInsets.all(4.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: new Text('Categories')),),

          // Horizental list view begins here
          HorizentalList(),

          // padding widget
          new Padding(padding: const EdgeInsets.all(4.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: new Text('Recent Products')),),

          // grid view
          Flexible(
            child: Products(),
          ),

        ],
      ),
    );
  }
}