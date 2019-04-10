import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size": "L",
      "color": "Black",
      "quantity": 1,
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "price": 50,
      "size": "S",
      "color": "Red",
      "quantity": 2,
    },
    {
      "name": "Women's Blazer",
      "picture": "images/products/blazer2.jpeg",
      "price": 70,
      "size": "M",
      "color": "Black",
      "quantity": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Products_on_the_cart.length,
      itemBuilder: (context, index) {
        return Single_cart_product(
          cart_prod_name: Products_on_the_cart[index]["name"],
          cart_prod_color: Products_on_the_cart[index]["color"],
          cart_prod_qty: Products_on_the_cart[index]["quantity"],
          cart_prod_picture: Products_on_the_cart[index]["picture"],
          cart_prod_price: Products_on_the_cart[index]["price"],
          cart_prod_size: Products_on_the_cart[index]["size"],
        );
      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product({this.cart_prod_name,this.cart_prod_price,
    this.cart_prod_color,this.cart_prod_picture,this.cart_prod_qty,this.cart_prod_size});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // LEADING SECTION
        leading: new Image.asset(cart_prod_picture, width: 70.0, height: 70.0,),
        // TITLE SECTION
        title: new Text(cart_prod_name),
        // SUBTITLE SECTION
        subtitle: new Column(
          children: <Widget>[
            // ROW INSIDE COLUMN
            new Row(
              children: <Widget>[
                // this section is for the size of the product
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: new Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(cart_prod_size, style: TextStyle(color: Colors.red),),
                ),
                // this section is for the product color
                new Padding(padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                child: new Text("Color:"),),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(cart_prod_color, style: TextStyle(color: Colors.red),),
                ),
              ],
            ),
            // THIS SECTION IS FOR THE PRODUCT PRICE
            new Container(
              alignment: Alignment.topLeft,
              child: new Text("\$${cart_prod_price}", 
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,
              color: Colors.red),),
            )
          ],
        ),
        trailing: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              new IconButton(icon: Icon(Icons.arrow_drop_up),onPressed: () {},),
              new Text("$cart_prod_qty"),
              new IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: () {},),
          ],
        ),
        dense: true,
      ),
    );
  }
}