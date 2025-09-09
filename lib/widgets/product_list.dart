import 'package:flutter/material.dart';
import 'package:shop_app/providers/global_variables.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

//MediaQuery Docs
// Establishes a subtree in which media queries resolve to the given data.

// For example, to learn the size of the current view (e.g., the [FlutterView] containing your app), you can use [MediaQuery.sizeOf]: MediaQuery.sizeOf(context).

// Querying the current media using specific methods (for example, [MediaQuery.sizeOf] or [MediaQuery.paddingOf]) will cause your widget to rebuild automatically whenever that specific property changes.

// Querying using [MediaQuery.of] will cause your widget to rebuild automatically whenever any field of the [MediaQueryData] changes (e.g., if the user rotates their device). Therefore, unless you are concerned with the entire [MediaQueryData] object changing, prefer using the specific methods (for example: [MediaQuery.sizeOf] and [MediaQuery.paddingOf]), as it will rebuild more efficiently.

// If no [MediaQuery] is in scope then [MediaQuery.of] and the "...Of" methods similar to [MediaQuery.sizeOf] will throw an exception. Alternatively, the "maybe-" variant methods (such as [MediaQuery.maybeOf] and [MediaQuery.maybeSizeOf]) can be used, which return null, instead of throwing, when no [MediaQuery] is in scope.

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata'];

  //String selectedFilter = filters[0]
  //The instance member 'filters' can't be accessed in an initializer.
  //Try replacing the reference to the instance member with a different expression
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    //here we are listening to changes in all properties
    //final size = MediaQuery.of(context).size;

    //search : inherited widget vs inherited model listning behaviour
    //MediaQuery is inherited model therefore we can listen to specific one property
    //but in inherited widget our widget rebuild also when any property change

    //class MediaQuery extends InheritedModel<_MediaQueryAspect>
    //here we are listning to only one property changes
    final size = MediaQuery.sizeOf(context);

    //MediaQuery.of(context).size.width * 0.3

    const border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      label: Text(filter),
                      labelStyle: TextStyle(fontSize: 16),
                      side: BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                      backgroundColor:
                          selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : Color.fromRGBO(197, 225, 252, 1),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: products.length,
          //     itemBuilder: (context, index) {
          //       final product = products[index];
          //       return GestureDetector(
          //         onTap: (){
          //           Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //             return ProductDetailsPage(product: product);
          //           }));
          //         },
          //         child: ProductCard(
          //           title: product['title'].toString(),
          //           price: product['price'] as double,
          //           image: product['imageUrl'] as String,
          //           backgroundColor: index.isEven
          //             ? Color.fromRGBO(216, 240, 253, 1)
          //             : Color.fromRGBO(245, 247, 249, 1),
          //         ),
          //       );
          //     }
          //   )
          // )

          // Expanded(
          //   child: size.width > 650
          //     ? GridView.builder( ... )
          //     : ListView.builder( ... )
          // ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                //print(constraints.maxHeight);
                //print(constraints.maxWidth);
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      //width is 1.75x than height
                      childAspectRatio: 1.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'].toString(),
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor:
                              index.isEven
                                  ? Color.fromRGBO(169, 225, 255, 1)
                                  : Color.fromRGBO(214, 235, 255, 1),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'].toString(),
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor:
                              index.isEven
                                  ? Color.fromRGBO(216, 240, 253, 1)
                                  : Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
