import 'package:clothing_roll/http/httpAddToCart.dart';
import 'package:clothing_roll/model/addToCartModel.dart';
import 'package:clothing_roll/ui/screens/productDetail_page.dart';
import 'package:clothing_roll/ui/widget/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:motion_toast/motion_toast.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  _CartScreen createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {


  late Future<List<AddToCart>> futureCartItems;
  String photourl = 'http://10.0.2.2:8000/';
  var log = Logger();

  var futureDeleteCartItems = HttpAddToCart();


  @override
  void initState() {
    super.initState();
    futureCartItems = HttpAddToCart().getCartItem();
    log.i("my products $futureCartItems");
  }

  @override
  Widget build(BuildContext context) {
    return 
     Column(
       children: [
         Expanded(

           child: FutureBuilder<List<AddToCart>>(
                        future: futureCartItems,
                        builder: (context, snapshot){
                          if (snapshot.hasData) {
                             return ListView.builder(
                               shrinkWrap: true,
                               itemCount: snapshot.data!.length,
                               itemBuilder: (context, index)
                               {
                                 return 
                                    ListTile(
                                    contentPadding: EdgeInsets.all(5),
                                    leading: Image(
                                      image: NetworkImage(photourl+snapshot.data![index].product!.productThumbnail!),
                                      ),

                                      title: Text(
                                        "${snapshot.data![index].product!.productName}",
                                        style: TextStyle(fontSize: 15, fontFamily: 'openSans', color: Colors.black87),
                                        ),
                                        tileColor: Colors.lightBlue[50],
                                        onTap: () {
                                          Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (context)=>productDetailPage(id: snapshot.data![index].product!.id)
                                          ));
                                        },
                                        subtitle: Text("${snapshot.data![index].productQuantity}", style: TextStyle(fontSize: 12, fontFamily: 'openSans', color: Colors.black87)),
                                        trailing: Wrap(
                                          spacing: 8,
                                          children: [
                                          
                                            IconButton(
                                              iconSize: 25,
                                              color: Colors.red[900],
                                              icon: Icon(Icons.delete),
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              tooltip: "delete cart item",
                                              onPressed: () {
                                                var id = snapshot.data![index].id;
                                                log.i("card id: $id");
                                                futureDeleteCartItems.deleteCartItem(id).then((value) {
                                                  if (value==true) {
                                                    Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                      builder: (context)=>MainTab()
                                                      ));
                                                    MotionToast.success(
                                                      description: Text("Item Deleted"),
                                                      toastDuration: const Duration(seconds: 1),
                                                      ).show(context);
                                                  }
                                                  else{
                                                    MotionToast.error(description: Text("Failed to delete item"));
                                                  }
                                                } 
                                                );
                                                print("delete icon clicked");
                                              },
                                            ),

                                          ],
                                        )
                                    
                                    );

                                    
                        

                               });
                               Divider(thickness: 1, color: Colors.black54,);
                          }
                          else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                        return const CircularProgressIndicator();
                     },
                    )        
          )
       ],
    );
  
  }
}




