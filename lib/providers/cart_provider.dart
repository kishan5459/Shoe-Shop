import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic> product){
    cart.add(product);
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product){
    cart.remove(product);
    notifyListeners();
  }
}

//different types of provider

// 1. Provider
//in Provider , consumer gives types of data which it have to get and it will be provided by nearest parent which providing same type data as consumer asking
// generally we are comparing consumer and providers types and if its same then value provided by provider
// return Provider(
//       create: (context) {
//         return "Hello World";
//       },
//       ...
// )
//below consumer find Provider<String>
//print(Provider.of<String>(context)) //"Hello World"

// 2. ChangeNotifierProvider
//it notifies all listner when any state changes happen

// 3. FutureProvider
// 4. StreamProvider
// 5. MultiProvider
// etc...