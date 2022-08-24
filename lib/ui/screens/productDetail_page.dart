import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clothing_roll/http/httpAddToCart.dart';
import 'package:clothing_roll/http/httpProduct.dart';
import 'package:clothing_roll/model/addToCartModel.dart';
import 'package:clothing_roll/ui/widget/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:logger/logger.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';




class productDetailPage extends StatefulWidget {
  final id;
  const productDetailPage({ Key? key, this.id }) : super(key: key);

  @override
  _productDetailPage createState() => _productDetailPage();
}


class _productDetailPage extends State<productDetailPage> {


  TextEditingController _productQuantity= TextEditingController();
  int productQuantity = 0;

  final _formKey = GlobalKey<FormState>();

  var log = Logger();
  var productName = "";
  var productDesc = "";
  var productPrice = "";
  var productThumbnail = "";

  String photourl = 'http://10.0.2.2:8000/';
  
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];


  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }


  Future<bool> addToCartForm(AddToCart cart) {
      var res = HttpAddToCart().addToCart(cart, widget.id);
      return res;
    }
  

  @override
  void initState() {
    super.initState();
    HttpProduct().getSingleProducts(widget.id)
    .then((value){
      setState(() {
         log.i(" my value $value");
          productName = value.data!.productName.toString();
          productDesc = value.data!.productDesc.toString();
          productPrice = value.data!.productActualPrice.toString();
          productThumbnail = value.data!.productThumbnail.toString();
      });
     
    });


     _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) async {
          if (event.x < -3) {
            AddToCart addToCart = AddToCart(
              productQuantity: "10"
            );

            bool isCreated = await addToCartForm(addToCart); 
              if (isCreated) {
                notify();                       
            }
            // MotionToast.error(description: Text("test")).show(context);
          }
        },
      ),
    );
  }

  void notify() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Add to Cart',
          body: '$productName added in cart succeed',
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture:(photourl+productThumbnail),
      )
    );
    // AwesomeNotifications().actionStream.listen((event) { 
    //       Navigator.of(context)
    //         .push(MaterialPageRoute(
    //         builder: (context)=>CartScreen()
    //       )
    //     );
    // });
    
}
  

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context)
            .pop();
          },
          ),

        ),
        body: 
        ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image(
                    image: NetworkImage(photourl+productThumbnail), 
                    height: 300, 
                    width: double.infinity,
                    fit: BoxFit.fill,
                    )
                  ),
                

                Container(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                   productName,
                   textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black54, 
                      fontFamily: 'openSans',
                      fontSize: 20, 
                      fontWeight: FontWeight.bold),
                    ),
                  ),

                Container(
                  padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
                  alignment: Alignment.topLeft,
                  child: Text(
                   "Rs: ${productPrice} /- " ,
                   textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black54, 
                      fontFamily: 'openSans',
                      fontSize: 18, 
                      fontWeight: FontWeight.bold),
                    ),
                  ),

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    productDesc, 
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black54, 
                      fontFamily: 'openSans',
                      fontSize: 16, 
                      ),
                    ),
                  ),
                
                Divider(
                  thickness: 1,
                  color: Colors.black45,
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _productQuantity,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Quantity',
                            ),
                            validator:LengthRangeValidator(min: 1, max: 1, errorText: "max value 9")
                          ),
                        ),

                        Container(
                          height: 50,
                          margin: EdgeInsets.all(20),
                          width: 400,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text('Add To Cart', style: TextStyle(fontSize: 20),),
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                  print(_productQuantity.text);
                                AddToCart cart =  AddToCart(
                                  productQuantity: _productQuantity.text,
                                );
                                print(cart);


                                bool isCreated = await addToCartForm(cart); 
                                if (isCreated) {
                                  notify();
                                   Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (context)=>MainTab()
                                    ));
                                  // MotionToast.success(description: Text("added to cart")).show(context);
                                } else {
                                  MotionToast.error(description: Text('Failed'))
                                      .show(context);
                                }
                              }
                              else{
                                print("validation error");
                              }
                            },
                          )
                      ),

                      ],
                    )
                    ),
                ),
              ],
            )
          ],
        ),
    
    
    );
  
  
  }
}


