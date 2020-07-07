import 'package:flutter/material.dart';
import 'package:fryo/src/screens/Dashboard.dart';
import 'package:fryo/src/screens/ProductPage.dart';
import 'package:fryo/src/services/database.dart';
import 'package:fryo/src/shared/Product.dart';
import 'package:fryo/src/shared/partials.dart';
import 'package:provider/provider.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {

      List<Product> alls = Provider.of<List<Product>>(context);
      List<Product> foods = new List();
      List<Product> drinks = new List();
      if (alls != null) {
        for(var value in alls) {
          if(value.isFood) {
            foods.add(value);
          } else {
            drinks.add(value);
          }
        }
      }

      return ListView(children: <Widget>[
        headerTopCategories(),
        dealsWith('Hot Deals', foods),
        dealsWith('Drinks Parol', drinks),
    ]);
  }
}
