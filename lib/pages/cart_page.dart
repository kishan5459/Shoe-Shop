import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    //final cart = Provider.of<CartProvider>(context).cart;

    //read docs of read and watch methods
    //final cart = context.watch<CartProvider>().cart;

    //read cannot be called inside build

    //watch() cannot be called outside of build
    //watch() rebuilds all child widgets therefore we use Consumer therefore it only update widget which consuming

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Consumer<CartProvider>(
        builder:(context, cartProvider, child) {
          final cart = cartProvider.cart;
          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index){
              final cartitem = cart[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(cartitem['imageUrl'] as String),
                  radius: 30,
                ),
                trailing: IconButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text(
                          'Delete Product',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        content: Text("Are You Sure To Delete This Product ?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                          TextButton(
                            onPressed: (){
                              // Provider.of<CartProvider>(context, listen: false).removeProduct(cartitem);
                              context.read<CartProvider>().removeProduct(cartitem);
                              Navigator.of(context).pop();
                            }, 
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                        ],
                      );
                    });
                  }, 
                  icon: Icon(
                    Icons.delete, 
                    color: Colors.red,
                  )
                ),
                title: Text(
                  cartitem['title'].toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text("Size : ${cartitem['size']}"),
              );
          }
        );
        },
      )
    );
  }
}