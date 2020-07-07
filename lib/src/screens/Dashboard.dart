import 'package:flutter/material.dart';
import 'package:fryo/src/widget/food_list.dart';
import 'package:fryo/src/services/database.dart';
import 'package:fryo/src/shared/Cart.dart';
import 'package:fryo/src/widget/cart_list.dart';
import 'package:provider/provider.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/fryo_icons.dart';
import './ProductPage.dart';
import '../shared/Product.dart';
import '../shared/partials.dart';

class Dashboard extends StatefulWidget {
  final String pageTitle;

  Dashboard({Key key, this.pageTitle}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      FoodList(),
      CartList()
    ];

    return StreamProvider<List<Cart>>.value(
      value: DatabaseService().carts,
      child: StreamProvider<List<Product>>.value(
        value: DatabaseService().foods,
        child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                onPressed: () {},
                iconSize: 21,
                icon: Icon(Fryo.funnel),
              ),
              backgroundColor: primaryColor,
              title:
              Text('Fryo', style: logoWhiteStyle, textAlign: TextAlign.center),
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  iconSize: 21,
                  icon: Icon(Fryo.magnifier),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  iconSize: 21,
                  icon: Icon(Fryo.alarm),
                )
              ],
            ),
            body: _tabs[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Fryo.shop),
                    title: Text(
                      'Store',
                      style: tabLinkStyle,
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Fryo.cart),
                    title: Text(
                      'My Cart',
                      style: tabLinkStyle,
                    )),
              ],
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.green[600],
              onTap: _onItemTapped,
            )),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle, style: h4),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: FlatButton(
          onPressed: onViewMore,
        ),
      )
    ],
  );
}

// wrap the horizontal listview inside a sizedBox..
Widget headerTopCategories() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      sectionHeader('All Categories', onViewMore: () {}),
      SizedBox(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            headerCategoryItem('Frieds', Fryo.dinner, onPressed: () {}),
            headerCategoryItem('Fast Food', Fryo.food, onPressed: () {}),
            headerCategoryItem('Creamery', Fryo.poop, onPressed: () {}),
            headerCategoryItem('Hot Drinks', Fryo.coffee_cup, onPressed: () {}),
            headerCategoryItem('Vegetables', Fryo.leaf, onPressed: () {}),
          ],
        ),
      )
    ],
  );
}

Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 86,
            height: 86,
            child: FloatingActionButton(
              shape: CircleBorder(),
              heroTag: name,
              onPressed: onPressed,
              backgroundColor: white,
              child: Icon(icon, size: 35, color: Colors.black87),
            )),
        Text(name + ' ›', style: categoryText)
      ],
    ),
  );
}

Widget dealsWith(String dealTitle, List<Product> foods) {
  return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          sectionHeader(dealTitle),
          SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return foodItem(foods[index], onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return new ProductPage(
                            productData: foods[index],
                          );
                        },
                      ),
                    );
                  });
                },
              )
          ),
        ],
      )
  );
}

Widget dealsWithCart(String dealTitle, List<Cart> foods) {
  return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          sectionHeader(dealTitle),
          SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return cartItem(foods[index], index, onTapped: () {

                  });
                },
              )
          ),
        ],
      )
  );
}