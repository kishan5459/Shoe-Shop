import 'package:flutter/material.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentPage = 0;

  List<Widget> pages = [
    ProductList(),
    CartPage()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //body: pages[currentPage],
      //by indexed stack our states(like scroll..) presists
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        currentIndex: currentPage,
        //we have set label as empty string so it is not showing any label below icon but space is also given to that empty string
        //to completely remove it we set its fontsize to 0
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value){
          setState(() {
            currentPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: ''
          )
        ]
      ),
    );
  }
}