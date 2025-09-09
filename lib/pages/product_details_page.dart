import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({
    super.key, 
    required this.product
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

//provider notifies all the listners when any state changes not happend
//listners are what which not passed listner: false while accessing provider
//by listner: false we are telling hey i am out of widget and do not notify me 
//by default listner: true
//but here we are not accessing state but calling method of provider
//so that we do not need notification on state change
//therefore we have to pass listner: false if not accessing state otherwise got error
//error if we not pass listner: false is as below :-
//tried to listen to a value exposed with provider, from the outside of the widget tree
//this is likely caused by on event handler (like a button's onpressed) that called provider.of without passing listner: false
//it is upsupported because may pointlessly rebuild the widget associatedto the event handler when the widget do not care value

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  //all is ok but how we can access context outside of build ?
  //its just because context is also provided by State class it is exact same value as context provided in build
  //note down context cant provide by stateful and stateless widget it can provide by build method and State class

  //here we do not directly adding item as same as in product because in cart we required size field not sizes
  void onTap(){
    // Provider.of<CartProvider>(context, listen: false).addProduct(widget.product);

    if(selectedSize!=0){
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          "id": widget.product['id'],
          "title": widget.product['title'],
          'price': widget.product['price'],
          'imageUrl': widget.product['imageUrl'],
          'company': widget.product['company'],
          'size': selectedSize
        }
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product Added Successfully"))
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a size!!!"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container( //OR SIZEDBOX
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  Text(
                    widget.product['title'] as String,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      widget.product['imageUrl'] as String, 
                      height: 200,
                    ),
                  ),
                  Spacer(flex: 2,),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(239, 245, 251, 1),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Column(
                      children: [
                        Text(
                          '\$${widget.product['price']}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (widget.product['sizes'] as List<int>).length,
                            itemBuilder: (context, index){
                              final size = (widget.product['sizes'] as List<int>)[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = size;
                                    });
                                  },
                                  child: Chip(
                                    label: Text(size.toString()),
                                    backgroundColor: selectedSize==size 
                                      ? Theme.of(context).colorScheme.primary 
                                      : null,
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton.icon(
                            //below passed function kept out of the widget build because we can also pass function like below
                            onPressed: onTap, //see definition above
                            // onPressed: (){
                            //   Provider.of<CartProvider>(context, listen: false).addProduct(widget.product);
                            // }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              fixedSize: const Size(350, 50),
                            ),
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            label: Text(
                              "Add To Cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
          );
  }
}