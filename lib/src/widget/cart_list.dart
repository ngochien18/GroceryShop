import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fryo/src/screens/Dashboard.dart';
import 'package:fryo/src/screens/PaymentPage.dart';
import 'package:fryo/src/services/database.dart';
import 'package:fryo/src/shared/Cart.dart';
import 'package:fryo/src/shared/Product.dart';
import 'package:fryo/src/shared/fryo_icons.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Cart> alls = Provider.of<List<Cart>>(context);
    List<Cart> foods = new List();
    List<Cart> drinks = new List();
    double total = 0.0;
    if (alls != null) {
      for(var value in alls) {
        total += value.amount * (double.parse(value.price) * (100 - value.discount) / 100);
        if(value.isFood) {
          foods.add(value);
        } else {
          drinks.add(value);
        }
      }
    }

    return ListView(children: <Widget>[
      dealsWithCart('Hot Deals', foods),
      dealsWithCart('Drinks Parol', drinks),
      SizedBox(height: 20.0,),
      Text(
        "Total Price: " + total.toStringAsFixed(2),
        style: TextStyle(color: Colors.red, fontSize: 22.0),
      ),
      RaisedButton(
        color: Colors.pink[400],
        child: Text(
          'Setup Payment',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return new PaymentPage();
              },
            ),
          );
        },
      ),
    ]);
    
  }
}
