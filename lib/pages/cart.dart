import 'package:flutter/material.dart';
import 'package:flutter_shopping/functions/Paytm.dart';
// my own import
import 'package:flutter_shopping/components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: new Text('Cart'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){},),
        ],
      ),
      body: new Cart_products(),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(children: <Widget>[
          Expanded(
            child: ListTile(
              title: new Text("Total:"),
              subtitle: new Text("\$230"),
            ),
          ),
          Expanded(
            child: new MaterialButton(
              onPressed: () {
                PaytmPayment(5,2).payment();
              },
              child: new Text("Check out", style: TextStyle(color: Colors.white),),
              color: Colors.red,
            ),
            
          )
        ],),
      ),
    );
  }
}